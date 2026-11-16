Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824595;
	b=wubHx1goaFSIGBzH6v0hgriwSYSSF0BOmu9m6EbqWSF7/B+cIWTrILiYfmoln0JvbzF5
	 CS+ccVzIQ+8AQ3XfYJngAFrdIXuafwNP/gz4KC8VebVCTyX1F0HZHWsDTld2JyNH/4rdQ
	 4peOM6t7OEtrNwEgdZaJ+LlMbXtVWf8gq0pgA9h6xlTybw6pfb1Jr3dWlKY5XEjwZv391
	 u1kUOaCbV8C3dtWQwnsNxsXJleOLMa/JceFOVTtQTusIixBcwbm1C8SeeYcdhvipCVh0C
	 zWCT6rFZkrV43K24L4ZuWVspvnbYdmuFhJwqo2OHdaaFaVf2Z0pDeVVZEbKPNmMvgfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+Z+9Ajv3xyJmoB5H/8jTZN0dMUeUUYatOho4V13GL9o=;
	b=gmS1ums7cJgDzh7emKtVt+GYqvH0uRrJiCheMCeTvTK64yMYzG4BWIaOHBUAbognvnDg
	 VkanITewlmIgS9JWICDuiV6dPaQkYPi6opgR8/g2gufudEg0XY/rsh5TjcPVPHipHftzR
	 hREMW1pcp4sKQapEsnsTyj+SbGSTZgmluG4MAVlasW7yVY4cjqCnhAT5YGCEd5eS2Nfhx
	 M8w4603DTA8Qah36vEF8XQvVs3fJNGzfaIKeBijfi5xXGuVt1+UXMB/wDTVnFCJFw70R1
	 cD0kaDc/vMOV77OM0HcdM1brXQSJAwTOej6gCEdgI5bypoNdSo92Vc6E+SGZSmv3Y1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ev6u7bg8;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE913606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE913606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ev6u7bg8
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-492f563d1c6so1272430f8f.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794824590; x=1795429390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Z+9Ajv3xyJmoB5H/8jTZN0dMUeUUYatOho4V13GL9o=;
        b=Ev6u7bg8Rg6ax0mUmXVgVdgStOD9C02I6qEPYaG4s5jtP3kBSQusRYR8OpFgMtqrJk
         SHmmYBCTGWQEkdqzKDbfOxUQVyRN06eWBZ3f/Q51vxVY3uG8G63Ez1X5Ak1gqv+wavEN
         Ef9Rmo2JStYusMZhkn6y86mEkoDtW2xTpc3qyYnaMCRFFNFa0V3B5AoaHQHR+4mhlT2d
         V0iOsCk10x+roDEejTdSyoyWmUlaXfMITEFfybEp+sd2hMZCyrQBa7arMdYGUkfS/7M3
         A2O8SkGvGrsd+zNB8NVJqrUTumuwU9aVa3sZxX3Fn1VZlWrC8CsgaZ6gCDFR8n4XmNQf
         MOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824590; x=1795429390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Z+9Ajv3xyJmoB5H/8jTZN0dMUeUUYatOho4V13GL9o=;
        b=Elww7HqLjKw9v9kwlsw4s7+Rdc6YHlvCQkbX2bL/iGMnfwYk7BtmT5S+r1pEnRtf6l
         L42nu5eQ6+nufOYt7UW3C7IyrFb6TI94LifaRvNnNH98GUC1b81yMgU1Q1rsb1OoBZSp
         qqovhzLbcmo0ogVCdg5M2uolzUnwQlqcqQs5tYz3D1nEzOTGuaYZaIb2I5PN7MnLW0to
         k+16jjOiJnBQscj/DuW4HFGhSx4/bOsI9wcv8IfWt+hWhWKERg3BouPQ3ofq2Fy3xy/b
         /AqdVWY6FgE6pevak21bJk4qc3+CcJFzJxevQnu0ByANsH5xQpKbwikfFa+YC3b9GuSa
         koEg==
X-Gm-Message-State: APuU4Z/9Vbcf4tdtG8EDuNjNjp7YSNE9HF5hisKv9+RIt0s5KIpJ2qs6
	5zchY6xYJI6my7PBlskzGn7AFxm/XEJYUa9X1WJnOIRDNyQR31FCOiYKPxGO6k+n
X-Gm-Gg: AZFdTZfIWaLh/Bg4V1r42Ocu6Cbfc+N2uOGJwZRNVKpOXWB6oaPP6jLBsCzb6rVYqlC
	4lV0mnzl9DMciwiS4i7ZlYJD7LBgsm/4a+eQIFIcZye6bdAjs14jdVzZ1w8WDEMr8yfoGjCqA3p
	R3WtkGQtdizzoCiIJ3V4h/SIq7mXnjmYuz8VROzr6b9taRp/MgMZCJEEWcpBClTdhYDK+ykrMNW
	XmlfRyksXtO0cGJU+h/PGJHZPPqL022pXylo3JTapFI7n3PX6VpAcybqr+OcCRAs5oYuWmSNfyc
	kGRGPfIr1xAj6IZW48Ma5Yq0FMdTXzAxRun8YzbDqURQKo0q+4BztimT0iQwDLt5ycb+OcUBV/Q
	2Wfv1LxdaP3lS7/aY0DoZQYOYwIcaHeilkJChfiW7ILwCTnW4kmKgyWkXJvycEFmqgj5RpX7EgU
	gUUl2w7SqINStXeeos12NnOUaJMpI9atK19qba+i425G8O+dapaDb8QC/nPzff0It0PEucFlrtl
	HeS0UbMoFCGwgFnTbpRANkZY+Rm7HL40TrK2YGUvK6JMvBiFHGg6BuXOooD7WX+uY+pMesEFcCj
	NayDh4t48plORNZZ55Mh6zD7NL/x84HxCvFadVjFg1U=
X-Received: by 2002:a05:6000:144d:b0:492:880f:494e with SMTP id ffacd0b85a97d-49c72c9c630mr23730288f8f.40.1794824589695;
        Mon, 16 Nov 2026 02:23:09 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608c5debsm20788426f8f.42.2026.11.16.02.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:23:09 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Su Hui <suhui@nfschina.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1] fs/stat.c: avoid harmless garbage value problem in vfs_statx()
Date: Mon, 16 Nov 2026 17:22:55 +0700
Message-ID: <20261116102255.80986-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Hui <suhui@nfschina.com>

commit 0fac3ed473dd2955053be6671cdd747807f5e488 upstream.

Clang static checker(scan-build) warning:
fs/stat.c:287:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  287 |                 stat->result_mask |= STATX_MNT_ID_UNIQUE;
      |                 ~~~~~~~~~~~~~~~~~ ^
fs/stat.c:290:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  290 |                 stat->result_mask |= STATX_MNT_ID;

When vfs_getattr() failed because of security_inode_getattr(), 'stat' is
uninitialized. In this case, there is a harmless garbage problem in
vfs_statx_path(). It's better to return error directly when
vfs_getattr() failed, avoiding garbage value and more clearly.

Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20250119025946.1168957-1-suhui@nfschina.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ Petr: There is no vfs_statx_path() in this tree. The fix is applied
  directly in vfs_statx() by jumping to path_put() via a new out_path
  label, preserving the reference drop and the ESTALE retry. ]
Fixes: fa2fcf4f1df1 ("statx: add mount ID")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 fs/stat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index ef50573c72a2..bc2b1f3a3860 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -231,6 +231,8 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 		goto out;
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
+	if (error)
+		goto out_path;
 
 	stat->mnt_id = real_mount(path.mnt)->mnt_id;
 	stat->result_mask |= STATX_MNT_ID;
@@ -247,6 +249,7 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 			bdev_statx_dioalign(inode, stat);
 	}
 
+out_path:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
-- 
2.55.0

