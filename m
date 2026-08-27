Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77A3469EE;
	Thu, 27 Aug 2026 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811153; cv=none; b=ErFLjtv3CAEcsGV6VKnKzepODDNKB2xwY3ADeJqotPOlkBgPsRZTSuR/W0MKRQAGNKsx9pbbgpC1Cy1mW5ileXetpvH4q2tc1mJcGJp8MApgnsz0g9y+KbZh8EIcRbwiaIHtnT5wld5Vm1RfN29NwjBnZtd4x7lGm/aPCqdPU04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811153; c=relaxed/simple;
	bh=t5MYV7cZdDIsmBbUr6XOpq3yhqcIhkeeK3ZUJYW7opk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S7HpilO9HqjNEf5FRX4Iwc3ntbguCZg9HOnhxqFIZQQyQ1kZZb0dYMg8OxlvXwV2MaOWE/MRYnnElq+HT8odR/I70fxCeVdn+AsW0/jHqNvL5p33ROyffx4gKaWlTQwGDccDw479P7yEi8oJqPxrFm1H/K2GUy/PVIoJUxknKNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Db99sqGZ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Db99sqGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Xx
	TRVen0aBOT3RRXArt3lC+66Pa7fnlDOtTYDDGX8Fc=; b=Db99sqGZg3ubxFqzFF
	YEblsfLn+826MEu9B8wUsiupFGaY7MWmKkTfdpq/K9BdsZDQTeKWVmdSESN1NCnq
	/LEvDXVGCF+wsIKaAyw+hB8eeR4nDgI5DwqtN0iVJNQ5xX2YicNV5mQsM6yYWkaI
	nhPrQCcO/9loYtoF11QXerUM0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC37aUx1Y9qkXlaPQ--.24874S4;
	Thu, 27 Aug 2026 14:12:03 +0800 (CST)
From: ghuicao@163.com
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cao Guanghui <caoguanghui@kylinos.cn>
Subject: [PATCH v2 3/3] md-cluster: fix ack_lockres leak in __sendmsg error path
Date: Thu, 27 Aug 2026 14:12:00 +0800
Message-Id: <20260827061200.79753-3-ghuicao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827061200.79753-1-ghuicao@163.com>
References: <20260827025229.40138-1-ghuicao@163.com>
 <20260827061200.79753-1-ghuicao@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgC37aUx1Y9qkXlaPQ--.24874S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy8Jr4xtFyUJFWxWw45Jrb_yoWkuFg_Cw
	1Yq342gFyrKr1fGFW8Kw1fZryI9w1kWrs7JF1xKF43Cwn8Xrn5Cw1UWasxuw1kXFWjy3Z8
	Jw1kZwn3K34xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU89mitUUUUU==
X-CM-SenderInfo: 5jkxxuldr6il2tof0z/xtbC4BMAkmqP1TMtVAAA3b

From: Cao Guanghui <caoguanghui@kylinos.cn>

In __sendmsg(), if the down-conversion of ack_lockres from EX to CR
fails (step 5), the code jumps to failed_ack which only unlocks
message_lockres.  The ack_lockres is left in EX state, causing a
cluster-wide deadlock as other nodes cannot acquire the ack lock.

Restore ack_lockres to CR in the failed_ack path when an error occurred,
so the lock is not leaked in EX state.

Fixes: 601b515c5dcc ("Communication Framework: Sending functions")
Cc: stable@vger.kernel.org
Signed-off-by: Cao Guanghui <caoguanghui@kylinos.cn>
---
 drivers/md/md-cluster.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -801,8 +801,10 @@ static int __sendmsg(struct md_cluster_info *cinfo, struct cluster_msg *cmsg)
 	}
 
 failed_ack:
+	if (error)
+		dlm_lock_sync(cinfo->ack_lockres, DLM_LOCK_CR);
 	while ((unlock_error = dlm_unlock_sync(cinfo->message_lockres)))
 		pr_err("md-cluster: failed convert to NL on MESSAGE(%d)\n",
 			unlock_error);
 
 	return error;
-- 
2.34.1

