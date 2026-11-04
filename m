Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817925;
	b=XBE+AcA9O85qwFyLcXxsEwfUBfmdWZdxmaBgeO+H0a4TyrubmLHxJEKAIa3nYbFHaHSC
	 4xopDQnJemHoEUgKoV1DG70I9+sA5sI+ReB8fp/eNJeWhYQ3XNLvU1lHiaEoWFbiJodkv
	 mVnan2lfe7fQL9GcCGG4WlKACaBXXUuZkC3FJOjAmROQMFPw5DF12cdRYrr2kEYKYQ8CJ
	 m/aRll/wPw/5byO7oBcVR6rgpZAqe4S6ZT//1+UZn/Wfv8YicEpujsxTiPiUXfy6sjUHP
	 aVMykGSPzW2ajYJz73MmljdwTkBLfbGYDvlafGIUThZ9xC7kPqW4w/Afh8Pf4o+cVFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JPw1QwY9l14AppDgzi11II1h1/e89fvFO5BaBQtgmgE=;
	b=Xn2V3B4gUBaW4llnsnQerkBs2y6Td3vfTUBboJaN0DEpNno44mSgUrmDMoZgQLT8veXD
	 yOdSVnCJkD4N9YzLkQM6zFx5Bnl0TJHwW3uy5nAUqfmPD1a0krE2YY022gprNDOGRsKvM
	 f0RXRRsP2EwNIaPsZohyBntHIirXtLPU1xBx1V9JFZVrB6pueppNbTzKY1CADsmQ7LUCn
	 oVRm5G/D/gZM997SswxZ5YeTJFnmuyHzqDC/2SeYzy5e36KKiplc5k4CckMkZoKPxjXD6
	 JkhwfkIvo0ZlotI96VZZN+/iwVG3Hwq0DSAkz4WZaQ6FRx5wvTVum6WyXhf/ib1/h7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0DVQoPSi;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E03606A333
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36E03606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0DVQoPSi
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4b467581b98so7692305e9.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817923; x=1794422723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JPw1QwY9l14AppDgzi11II1h1/e89fvFO5BaBQtgmgE=;
        b=0DVQoPSioNKOoakF7h+BRcrSTXgOfuGcaCzvwo0RBcpnQX258Ph5HSHH8GWsus/ljZ
         9kE4q400T4Wzf+8sn4tt3E3RyUDNInqOlceCJbrLgWQ7H67LdfTiqGH7fHSc+RGx2+vC
         FvHZ0+NFKJz+zfuyG2XgiYMFF4BGGj9MMUvzgXkEkrOQWpipI9z7n8ikNeEV+TugePsn
         s50h2wgMOw6hQux5CTCYWdewO7B0neVZ/YDrDP7e+xipi60xiaiBhkfH/6gQHISTNhcJ
         ZmjGhqTTW3ce/XWcwiBv+kCpR5V5XLZ3Rs4zZAx8adFrt0KhhkMvKrpsrMau/cBjcqtx
         BGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817923; x=1794422723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JPw1QwY9l14AppDgzi11II1h1/e89fvFO5BaBQtgmgE=;
        b=i1y/0agnZFrz4TcU3zdvKXQqGm32eBx/0+qVnB0e8eHt9UJFfSRFCdcih8WxYj/iBX
         QPoO4y0PkLh6IuTFDt3MpCThFavEyG4z7JFh1adrCYo718eyULFxq879Ef8Z6BV19lJb
         L0O95ahZNYwdtDMahyIiSc3tmVANTqBpOx7ksBVcOyneBTZgPcUpu4O8curzN3rVPdz0
         DE1NlhIGEmr9/cVFUK63CLYdryPtk2HMNAezlUmyWxX8chTVfnpAqE07FUwQKhvBMRbM
         HuEI8FTXqi0hfRujN+g/cm7GyORKIun6WYm3A6cnVk7owVEsFVjnsYjlWDa3QJu6Oc16
         SIVw==
X-Forwarded-Encrypted: i=1; AKwUvBynAWPQW3EZycpUQz7KLzSjvmq+W5gzNt2AqmXGC7iZ2embroM7iIcsta6dAa614kOw6USgzMA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mvrCCUIqp2Ry6OxrRJbVpcWxK3LhEsAV/Xri0/ujfKzfzimAn
	gKZ3XpeIffPRtTUIUtq19LiY9KtZt4qk9d5dYWtKLE+6mwDq4jkv0kch
X-Gm-Gg: AYBFou3HJeL3jxuDO8JXvGqN1l7Bts9Y+ewWmRrnoUWRTQQn5JKV3V5llWwHEvPT+5m
	/UzA9l97nObitIB+bwijNLRmTjwBCJnt/lDOeHBM4bS7RmZZFlCs4kikAL99sbsDuRJtLiqzJJ7
	U5C1eEeJ+EvtVTOHhneYTtOUHNX+PUDAglt8rz1BVsVJLgEM6mz7aRwbpQ/csIhUk0W9sZJEjje
	1l8rZmxAm/vP+B6D6v6i7OwEL21RTqH3JNoxCxAEglVwwukphrhfVKNlrjSIrrNYZ5wBBTzcAPd
	oiwVry1YxOT0JOJjToEAMeVexBIrw1T8oHZm3Sq8IQbTf1PVZ/vDorubyGB1xVE4FIa6obU990g
	FhzFsLzeqH01XOE/I5TnfC7vJDWq33VmeXpSpZQk2dzc5ylLyGsbzbjC2wcToNUeDNC3CSFafCr
	S0isfawqghxDf/BdQLj5zhSvqOU9vbVX6g1sOKyl+EV5CQJ2sSVG1Vc04lAJcnuO6GCHXBzYWF1
	j79Xain7aNNchnUTY0tR7f9ZFn0UMHeeYzJY7vH7Y8D5sqVoBbkpk9vo9EmXq4jvhpkF0a7lc+D
	QRgenfpsw7RLrtnvnv32vYkMlV3JyhlF6heASSFfIMYZ5BlBxbG0jw8FIBrG9fZtDY+gzJU8Py3
	FepfS3jLpIJsw
X-Received: by 2002:a05:600c:4e43:b0:4ab:e27d:e241 with SMTP id 5b1f17b1804b1-4ac180f28f7mr369940825e9.15.1793817923473;
        Wed, 04 Nov 2026 10:45:23 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57203a98fsm2821325e9.4.2026.11.04.10.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:23 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.18 3/3] ovl: do not copy up a dentry that was removed
Date: Wed,  4 Nov 2026 19:45:16 +0100
Message-ID: <20261104184517.3630089-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104184517.3630089-1-amir73il@gmail.com>
References: <20261104184517.3630089-1-amir73il@gmail.com>
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
@@ -831,7 +831,14 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
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
 	err = ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0);
 	unlock_rename(c->workdir, c->destdir);
 	dput(upper);
-- 
backport

