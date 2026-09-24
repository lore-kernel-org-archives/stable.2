Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86A4334CA
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235568; cv=none; b=qjrwoVtR9ncCgCrYx3dNCWxnDZgheSv0ebQceiXsXUTDzg0g4XGO8HlIAlJeIbftzOiftqazcPFOJNaSQxpEQT2WX4dvEnBLcN1wcony86rZAx6UFAoM+UlnncHEvsXI4/49F4XXdAYLcgW9K6gYw0YICZncF3GHA2hC1JaYkUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235568; c=relaxed/simple;
	bh=+VlMZOALNoTVxwvqqOHNg+HWbZydFH9BbG4DHncGqes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIt45yJUcf3iSV/7acB2I5Ab5wVKhiZ7wZvJMmSUA8lr28Q6MXlGy7wCk6oEaqdBLajzeHp8u2Ut4+RwwsDcE6qoGNnPQzMzElbUL9pvKLEDaQoXfo+GOepbwSFFljJR+dqVsgoZJZez9qimaX3AznrqeaR/CZAkZkOAhrvSJAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R51z4+HG; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R51z4+HG"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so967004b3a.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790235564; x=1790840364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6HiNqskXz+7GrxS6wHzPZKAwsfj0AyVFsyoKCtHJ2g=;
        b=R51z4+HGI4YrJz66Hz+x2kyZfwba06+ypVMpHRr7/N73oDAvic/658S8bxQznNOD6i
         QXL2nzcbWdH2djR0Qf2A0qpcM4HeoafOzjDY6ys3PEUGZY9f3+v1qayrF2yBqVxNEial
         sOX2wfFbI+0zzqoe73tHHc3YGXUiL87ai1IUGXoO7fYBjM9huXlnX2hpBSuLfcTQk578
         oQYaooc1CLRgt/KaYB7U9Gi1GP94z6UhO7Fzg7u0RNmy2jnB/7KDF2AJDBnyYoaAN2zS
         Cmn8IuO5tZ/zs9U345Iyr437NMt6HhMqP5fdfXk5HmS7x8mgu0lCG8R8K7W0E6dCKU/g
         3Y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235564; x=1790840364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n6HiNqskXz+7GrxS6wHzPZKAwsfj0AyVFsyoKCtHJ2g=;
        b=JyjG9cbuiR1IyCLPQ4Zt4Jjff3+y4vDrmw92+FQIvR51TOwpn+1tD/Z1OlH/SgUUaP
         LFge2Eg3wYasGz6CzOtsBv3A1Zh8vnS75vd5EXtUlUp8atqVAgqV1BDUhYPTeGjxdA2b
         LTlZN4mvY/hxir5vKPTaaTRc7GWxSUzkgI5TThppUYdxGaGKsvhkPWIOgvtmWAbuNlof
         Le2E6l4Py4xLqeqWVPRAsX83UxbbAsh0Olnoc9GIKWd3DV2YAJAs0CXCz6fE10BnIhoq
         BeZywf8BMEIVeWEMIv3kFWU2D7O6lt/Fv/z5Yl98IPkoGF1jnhocrBpSX2ILeQYI1Fgj
         byHw==
X-Forwarded-Encrypted: i=1; AKwUvByheWas1nufVIFQquGQtiB/tY0WU2Xkar64nBFB9/Mc146OAmxeiOMuUowgnRi1FvRn//aNAdw=@vger.kernel.org
X-Gm-Message-State: AFuF++nVd2hnBQ3IUW9JQ8dVRymKRpBQB1euyZu/iVcen+RjRPXY4EDu
	93/gH8s2X870sEFabSGNSl/HHE/dMjL5osz0LjIeXItgbWyWvvrWN40g
X-Gm-Gg: AYBFou2xS2gbrNT+6V6YzUFbnLQrwCNGN32syHLfaKHx+Jxnd4aHkVQG1aGSR8XT/Rk
	bd+Q286/naGkx43mQcP12TVeNUn2FTgdmXkpxpr/MAOUQWjsFE19LO5sC+pvPyjE3i1kuCCOgT4
	I6iaDatjQpnJx4zB/F0oI1xLozUIVPoLLHMgtw0jZnux7xTQfV95+8rn9u7l86SlxjFSn7FAoQS
	TFNQCfuFlOnE5gxfcwv22Oklt77nF80yMIqLC2J3hMS+YID1QW9Tkea36UB1fVC4A1rCp6PKnRC
	UJVikPI0E/Z64mxCJhOjxMDC/oSvCYkv41EW5Nr4AyaZeg+45o3zJFYNHweA8hGOMt8gnUpb3Zt
	XXL/wK7akvHCAKy69hgpd5EuDAKQmxD5TVHC6W5l6K0vbqfXe4/B8goPqu+wluPeaVUq7BxQF+A
	/+uD1QoT7uslB9XIpcgxqwzpoJ7IZ72ltTaXcdPxHt4z/mQZjROin70pSFwgRXhflBCCqVmwJa1
	2PoVwH5nQaZ4GqmpD50hJADzD0oIYAOPgsQ30gVeZYoUeBB5RJF5OAWWrYudnO0byBFk6j6XViL
	BEK8sCIeBr8=
X-Received: by 2002:a05:6a00:90a8:b0:86b:4138:4084 with SMTP id d2e1a72fcca58-87e98f8ccd4mr1408808b3a.15.1790235563675;
        Thu, 24 Sep 2026 00:39:23 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dad44c6sm2393739b3a.42.2026.09.24.00.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:39:23 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: al@alarsen.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	matthias.goergens@gmail.com,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v3 4/6] qnx6: release sb_buf on mmi_fs error path in qnx6_fill_super()
Date: Thu, 24 Sep 2026 07:39:17 +0000
Message-ID: <20260924073920.2782917-5-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260921042511.1473629-5-benquike@gmail.com>
References: <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-5-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_fill_super(), when standard qnx6 superblock detection fails, the
driver attempts to probe for an MMI variant via qnx6_mmi_fill_super(s,
silent). If qnx6_mmi_fill_super() fails, qnx6_fill_super() returns -EINVAL
directly without releasing sb_buf (which was allocated by sb_bread(sb, 1)
earlier), leaking the buffer head reference.

Call brelse(sb_buf) on the qnx6_mmi_fill_super() error path in
qnx6_fill_super().

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Add Tested-by and Reviewed-by tags from Matthias Goergens.
- Update Fixes: tag SHA to 5d026c724220 ("fs: initial qnx6fs addition").

Changes in v2:
- Split out as patch 4/6 as requested by maintainers.

 fs/qnx6/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 70438cf5efdf..49e29a918a2d 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -340,8 +340,10 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
 		}
 	}
 	if (!sb_buf) {
-		if (qnx6_mmi_fill_super(s, silent))
+		if (qnx6_mmi_fill_super(s, silent)) {
+			brelse(sb_buf);
 			return -EINVAL;
+		}
 		return 0;
 	}
 
-- 
2.55.0.1082.g2b9226bbc0-goog
