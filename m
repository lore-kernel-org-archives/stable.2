Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B873546E4
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 04:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964719; cv=none; b=T+BRYpTlEJbWEwWl54sLnYnhWfMt82ao593NDaZFwAslwsPHN4weuYMLQDBV0yvk5G5HRg/U5jJcZAMxIKPqksDP6kJrT5VG/CLJ8WGxPG50bFz2OsOksoC9A6gkx2bE6f8tuUuBNHI6dIWWT5//Zaue/ZofN2FqPBGadclAemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964719; c=relaxed/simple;
	bh=UXX242uwM9CJbd75dgBpovw7CdyRLI0nhFevS4pmY30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9+hgwpUrQYmkm1nZr3bwDrP0ZAZ+/XBERtoucIIeSs/VVn7h6dOUNQSumpQZVhBaiIZPnDyCt2NkebKGSbNNRGQRMGtvP761F0czsIohYf07YlV5qGAG1dV1CICLKzC6BV+Tml8ikfL/9Y9EISqtA3CzGKPMAJiZ2Xl6gAsUmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYZIovRZ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYZIovRZ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so1875412a91.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 21:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789964715; x=1790569515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KlcejhybFRwk+waXcujN7WP0JBvoJyfPnbBAG+LwQp8=;
        b=AYZIovRZoyIsUjyI3U/Z4K4eWjMmJ3TNkBIREnYW4m97iy1yqLPdxVjaWepLcxvM9Z
         k0DJMAmW93hnBL36osPKT2sxw3E/eC4Te+nHiD/aU9cnotZix4LPwlV4OmfkHqXfD3+/
         7FJv5uc9ts5aYh5WcZBzDEB184slHv6028uHiOuCFrLucXF/d5SASqe/JhETxxFHOsjH
         zwQug/GI6lgh4aUap2YCeI0UL9LmsNqfDtUL9yw9R/TE51GN/LEei/HSY370NamadSMj
         6d71YovcZnGL8LShcuiPWSASjnnzsaqqQ40WAYwhtLJuuoNCevhyANoLsLW1ftMXJ566
         qYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789964715; x=1790569515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KlcejhybFRwk+waXcujN7WP0JBvoJyfPnbBAG+LwQp8=;
        b=X+MsTe+HqrFmWHP8jEW9C+hv6v9SLgBMGz3oSk4lWSuhYBrEspDr3x2OGk60u7snJ2
         +YSaRwvF1S0X3IvVhaxv5w1/WLts6JKgjmF+pxkuGxzAKhLCp4FMX0ir3EVFV0hTlKbX
         3vzb02tKtPawQpl+i2aiabbFD2tKWJUzJfAyi+s9eKpdbtwV3PUzD+Z4oKnGVHgtkVZ4
         KpmqezEiBa+dnNI7dqt4P0tunl6+yFYgpW+lG5nEib1b71yO2Ph21Gj2dONMCam7cE17
         AuBBxqRYlgjTYNS8QjDe1YPhoLLz2MCbDnsfWamJvcxWXVQPuLIpUcHBmBUucGYbGmSB
         PUjw==
X-Forwarded-Encrypted: i=1; AKwUvBz7T+i3jGOKaCmCHvHqcdNf//mgsdzdEG1SqmUrIWmKCzzrWqmzI61LaglxiRAhf4L/qoR+i5E=@vger.kernel.org
X-Gm-Message-State: AFuF++lybp7gnPEz7t02Szg6oqFT+LWVnphLU0BMX/SjgtnLWLy7TytH
	yKg3KRAKpgsBZ5JksDzxsqt+LgtZhWLnW1/2MeaNsnfRmMTwxKoBVEHn5g2+EYMP
X-Gm-Gg: AYBFou1rzI1fNX9AQFJNzpyiSjggq9EbpjWxH+dtDmSDP1D3qpKmmDLFfnP3VLHZybl
	dd5tgWteekVZHaZtkiQB2srk5rWwztJgG6xs1i1PnL/qr9fIhO+hHteMcqcdPpweauFv8mVlJbM
	rOGzi5xxn0lLJjh0z8SAZxEPqJclgZ0IK/kyHAkiUovKfeEw9s2dKUKwqVm1PZeCAcNxE2kBtf8
	UJISLMpnEgP8eF7yqA23QoWrGtMsQ+D5MXvk5D2OMtD8R9jeTYN/019GrhCwkJXUpAfXdmvDbpI
	o6uiyleVlIXzAjPKJm6oEkmiYPILb2TfTlKZS+SvxsaL/OlI1YAc8EG2TzV4TnJdo1ChpBiGSQd
	4xPUA+HvKp38CkXcYxGc11T58wPL8APJjnuUx29yYeF9aNcJYrAe5gu0W0CoCijkMscimOMhvq0
	4AEHHTmdQl9wHwckPPoNMmQw7hqQ8vca9WymY6P7BbQqX9zjmbIU3S0WkW6z4ELuvULjjFByc1k
	al1zan3d3xsBWq5Faxp8aPSN8HCAY3SnuezEckypoGNqsS3nJ+N5Mh9ELMYJ93wbssDdi+ROO47
	67e4nGYHKQ==
X-Received: by 2002:a17:90b:3909:b0:39e:359f:8539 with SMTP id 98e67ed59e1d1-39e54f35cf7mr19843880a91.15.1789964715138;
        Sun, 20 Sep 2026 21:25:15 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c5b3932sm11742139a91.13.2026.09.20.21.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 21:25:14 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 5/6] qnx6: abort mount on superblock magic mismatch when silent is set
Date: Mon, 21 Sep 2026 04:25:10 +0000
Message-ID: <20260921042511.1473629-5-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260921042511.1473629-1-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org>
 <20260921042511.1473629-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_mmi_fill_super(), when the superblock #1 magic check fails and the
silent mount flag (SB_SILENT) is set, the goto out statement is inside the
if (!silent) block, so execution continues past the magic check with an
invalid superblock (unlike superblock #2 at line 93 where goto out is
outside if (!silent)). Move goto out outside the if (!silent) block.

Tested in QEMU against Linux 7.3.0-rc3 by mounting a crafted QNX6 mmi_fs
image on /dev/loop0 with sb1->sb_magic = 0xdeadbeef (!= QNX6_SUPER_MAGIC)
using MS_SILENT | MS_RDONLY and "-o mmi_fs": on the unfixed kernel
qnx6_mmi_fill_super() ignores the magic mismatch when MS_SILENT is set,
logs "qnx6: superblock #1 active", and mounts the invalid-magic filesystem
(mount returns 0), whereas on the fixed kernel qnx6_mmi_fill_super()
immediately aborts at the magic check and rejects the mount with -EINVAL.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split the qnx6_mmi_fill_super() silent magic check fix into its own
  patch (5/6) and remove Markdown formatting from the commit message, as
  requested by Damien Le Moal.

 fs/qnx6/super_mmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index b8afb6f388b2..18298e273a13 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -51,10 +51,9 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 	sb1 = (struct qnx6_mmi_super_block *)bh1->b_data;
 	sbi = QNX6_SB(s);
 	if (fs32_to_cpu(sbi, sb1->sb_magic) != QNX6_SUPER_MAGIC) {
-		if (!silent) {
+		if (!silent)
 			pr_err("wrong signature (magic) in superblock #1.\n");
-			goto out;
-		}
+		goto out;
 	}
 
 	/* checksum check - start at byte 8 and end at byte 512 */
-- 
2.49.0
