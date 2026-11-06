Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938294;
	b=wcx/Y3Q+IIkbdW7nep5tCVvNfOq3KskW5Z4d3gFhK2R17Y4pCkRoqLH12cUd8K/limb9
	 j0Z/p53h/Stid5euebs5iDJFo4a/DXSacuAg/cRUvU8alv+q96Rd786m4TwzXTT2xI10i
	 DYtFAl/DxOPZGBPHu0ewv9riXBjUFa9LoSVkxQTjmTXBspU5ny5UY4yq3VE0V0/QUaSf3
	 raVQIMI1cpARVImo43lkwQMT/SAsZbOWMlmYzUMmPy7UTfylP0UTHs3KCUT0/0jjLfhm5
	 HszfXjDzAsZs8rcxTIj5mL0lw8ftTrLk0z1F+TcznswZ+mc/gaqECQpEoC+1qIvnynQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UXv3DjTO2LLFBsmZPtGA7kNZEfxgdi2hpfVKVbn4VTA=;
	b=FBjZeY0ndAyuefWvNCwjLsHVDz7Ox24gIo34PCXHmiu/KxuJ6taIKNRU2V4M/vAx8XOD
	 vFCQ7kx7HCny7jV1DRYiUX5QEwYiklaeOug//wTDwFmZf9x8BAtehDlC0NBJneqPwNRQt
	 fgR6FrtHkwyAPne75inTLT1opmnHAOUZ2nhteHE9ntAOLErpf1nRG1lwtTsCqLXemsQSJ
	 yMAguTGOUO2ybNZrUKaj4hoIt1Mcm2d/U/9jlcWTnchJPNfGlFpVtsSuyfkLtlWmHj8Rx
	 Qzp0O7NQTuNrwPBUrvVaXi98S1cIFtEHT2QhgXXj2kRaRyofho8oRpX+ysXvwbBDo5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U82msg5P;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7000606A330
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7000606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U82msg5P
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c450ab1483cso31792566b.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 20:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938292; x=1794543092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UXv3DjTO2LLFBsmZPtGA7kNZEfxgdi2hpfVKVbn4VTA=;
        b=U82msg5Pm2cIK6BCX02AARih2EMsbfY6XvYbPdOLHr0RSCSzrrnErekTZo+k4llKOy
         bs4BiTkg4KeqCSKW2wSmwU6m0CCpIl4j182oSie3d3JjXqHyt33FskdHkPuhzkn5goHq
         fms+w8jpyWzEQfDF3nGAITCWR4ixnR0kOUc2bVJX9hk+bcPn0Yxgdh+WOo//Rhe8PWc5
         u4WZgPZ/7S4fS89QY++6FQd5hpYS3M/Y5OWBmaTI3CN+RYW/vbeKodIev1AZyrVv0ha3
         V2YcLF7ttNFPtvZ2Ik3+cngYCcip9QYXE5g8Qb8TQbXeW9IOpbqDXdP16nng/yLvf4o+
         HcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938292; x=1794543092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UXv3DjTO2LLFBsmZPtGA7kNZEfxgdi2hpfVKVbn4VTA=;
        b=CHQruDywQOcw6VSHCW7vDg1BL1G/HYaSUvDA8WiOdQKRnPI6pNwQwoDne8nq/rAVEk
         EGXzggEOiVnnoZkQzT0j7WMWc0W+oZ752CCK9yXzH1VOt/ttVBO3fvqPvOHlqsIJbi/k
         0LuOvCIbFM5sb7GvM3D2opyXX18YSzP8CH9ScbOw4KMppwD804ayDEcg2zuBSf7KkICR
         wXIqCztQLBG3BikDlqqI/fElMb2Vw+nXvQ5I9BlW0OlENAqseu728Fm/zyQihy4ifaec
         WFdW8xZP/0fZ/PJ2lfBssNkI9qNk9G/vmrR1RVI4PmqzLf3iD6QQ0aWvmZ68mJGZnZAG
         ISDg==
X-Forwarded-Encrypted: i=1; AKwUvBzYFG7v4TpayYsA7GkSB2STPO3Fw7EgqdJLk0nbop3Xv2o4nGDmYCwAoTLGZs8j9RT9xmzGnmk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EY5JJR3Vbb38jDBWcDEWB76T9KAs4UHHpYHZ2dcrM6KnSebYF
	jzviNT+WPrbEWzeEuz1gVOLa937cQ3hJhMxloteYdYRd3mmL2REXZdg5
X-Gm-Gg: AYBFou3Ut+5/6+PQy0saPjRF72e4/zX810h5+kk4sTn/w3u4hMeV26EqkLzJm6pJrkf
	1rTt7oXZYnzdIDQ3KmWpxMmbqE6y3phjD+1Y3jTNyeaCIuZTL8HiICjvDgyJvSCHM8VTfaDfSfR
	BuZjKYqiXaiIUOfQjhP6sOmRgdZ7d/unq8htC89Yemp3K9XKYDtIYCRupfJJlF2V6sMtRB+uc1z
	YjOH1z8ATEMeg/h6qq+qyRQlqz1Hi9JoqleAiwQlmr3tFJhAG7rIP/L7ykTdoLfTVQ5F/+ZqEo2
	dhVv6Y3UN9Bgr8Iu6kBtt0+VjUdQ9QVPy9K/yWvNFBUvFb3ZbFZ1qJt7rb4nizscOgNWK6oL+YP
	o4QGtxW1/bUq3ElEjuEBk6s/faWl+9zuVCJ3UXKiN7jLlbkpv8EJFx3FAkr7i45rc8kGhL0f+O9
	yl/Arx6prktXavynib05/jI625bK0ugDfTqUwobp9wh7CT8gaI5vRsrVhx++upRwabMI0togF/+
	AhsPw5KbmtGFpZx1PXKVaUk59M7oCCTvmAFM+uRMmRWlsxvzGeEePbZwLrRIf8oNzKtCr8XnFOB
	gu3yq1RdM2BgUAg14+H+CzcL9MxBN88F/o7SjlS1M4wrMjaZurhS/zeWDtPPRzRXY81UDuG1YyZ
	YreapdirMYPrwWRMQWoZg0rbFAXnYonTN
X-Received: by 2002:a17:906:9c89:b0:c46:ca3a:10d5 with SMTP id a640c23a62f3a-c4d35429e22mr109924866b.45.1793938292114;
        Thu, 05 Nov 2026 20:11:32 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d35673731sm41209566b.44.2026.11.05.20.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:11:31 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.1 3/3] ovl: do not copy up a dentry that was removed
Date: Fri,  6 Nov 2026 05:11:22 +0100
Message-ID: <20261106041128.3797453-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106041128.3797453-1-amir73il@gmail.com>
References: <20261106041128.3797453-1-amir73il@gmail.com>
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

From: Chris Mason <mason@kernel.org>

commit f635192ad223d2009ee640b63adf5ce3198aa338 upstream.

A change to a removed file through an open descriptor replaces whatever
has its old name in the upper layer.

Copy up must only create a name in the upper directory, never replace
one. After an unlink, an rmdir or a rename over a lower dentry, a
dentry that an open file keeps alive still has its old parent and name,
but in the upper directory that name is now a whiteout or a new object.
ovl_copy_up_workdir() renames the copy over it, which brings back the
removed object and destroys whatever took its name.

An unprivileged user opened a lower FIFO and unlinked it, root created
a file at that name, and fchmod on the old descriptor replaced the file
of root with the FIFO.

Fix this by looking up the target name of the rename in
ovl_copy_up_workdir() with LOOKUP_EXCL, so that copy up fails with
-EEXIST if the name is taken, as copy up with O_TMPFILE already does
when it links the copy to the name.

Fixes: e9be9d5e76e3 ("overlay filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: use LOOKUP_EXCL instead of relying on d_unhashed()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[backport: no start_renaming_dentry() and LOOKUP_EXCL, fail with -EEXIST if
 the target of ovl_lookup_upper() is positive]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -708,7 +708,14 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
 		goto cleanup;
 
+	/* The name may have been taken since lookup, never replace it */
+	err = -EEXIST;
+	if (d_is_positive(upper)) {
+		dput(upper);
+		goto cleanup;
+	}
+
 	err = ovl_do_rename(ofs, wdir, temp, udir, upper, 0);
 	dput(upper);
 	if (err)
-- 
backport

