Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234D1515994;
	Thu, 17 Sep 2026 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662432; cv=none; b=HfVqorz1nDYEvKsyO6xTtQqpGsZXXfkbDfZYT0Gk/47Imocz+sRYiAI1xKB0EBD2FC6pIR5leDK6bPZhiTXlW4NpHZq3YXWQXtelqS1jhgNl/F6go5zUESaFzjYD/sNpwYf3A/ClMv6LGmfnEEWVbSeTvq7OgjEBMAiZ8iPdN+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662432; c=relaxed/simple;
	bh=O7uLpQKNGJOxlY3T0kY8TA0B3L4WTuIwiwe5wpyA2S8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sfHvsLjTEEEaTY0ZEXHMdhWGmHgE5hm3m6KwGG4DvkLOn9dKzt5SOIWj873h8eHAwpYvH5In92AH/fhONAu5fFXjrEqPfyiUjZTDoizajXxy8jBchx85z7G0dRQNjg6e4widHM6Lyv32AMvCDcoyHv0sWEZG7r5G3Wa+0IOuxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHdkDYFKxqOnWECA--.454S2;
	Fri, 18 Sep 2026 00:27:04 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: amarkuze@redhat.com
Cc: ceph-devel@vger.kernel.org,
	idryomov@gmail.com,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: Fix xattr buffer leak in __send_cap()
Date: Thu, 17 Sep 2026 16:27:04 +0000
Message-Id: <20260917162704.2162206-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHdkDYFKxqOnWECA--.454S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWDtF1UCw1kKw48KF13XFb_yoWktwb_Kr
	Z5urykAayUKFnYvF1jyF93tF929ay8Zr1fWrZrtwn3Aa4YqFWrWrZIqF98ZFnxWa1xC3s5
	Gw4fK34UuFyxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280
	aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUjZNVPUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgANA2qr889P5wABsc

__prep_cap() takes a reference on the xattr blob via ceph_buffer_get()
and also grabs a reference to the old xattr blob returned by
__ceph_build_xattrs_blob(). These references are normally dropped in
__send_cap() after the cap message has been sent, but when ceph_msg_new()
fails, __send_cap() requeues the cap and returns early without dropping
them, leaking both buffers on every allocation failure.

Release arg->old_xattr_buf and arg->xattr_buf on the ceph_msg_new()
failure path before returning.

Fixes: 16d68903f56a ("ceph: break up send_cap_msg")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 fs/ceph/caps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d51454e995a8..41eb52b4673a 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1535,6 +1535,8 @@ static void __send_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci)
 		spin_lock(&ci->i_ceph_lock);
 		__cap_delay_requeue(arg->session->s_mdsc, ci);
 		spin_unlock(&ci->i_ceph_lock);
+		ceph_buffer_put(arg->old_xattr_buf);
+		ceph_buffer_put(arg->xattr_buf);
 		return;
 	}
 
-- 
2.34.1

