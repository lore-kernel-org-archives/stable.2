Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938297;
	b=mxWg5T/pD6mqkZUrD3UxOHPfhsHUoTsgbjUxGYUAjcEvNycgswxNpsDHmGAeXI7DtOX4
	 A/g+m30WQQi8OWNsWBs76noynzkTyiVA7lCzgcmZnhmUaEJNMwAJOUbuvcknq33ODvD3Q
	 51F4UUv2MRt2aYpDnevK0+qA85rvFnqX0B7E7kmWGvjF68FqVOuxmN4gchzcLlvajwiYg
	 upOCvHAC3VO2LafGnBK0haiP25cam2M3klI7F7YosfXmmC4sJQX2CTLZjeX7buDiJ74Iv
	 Oy5gzUD0/H4r7Zgw1VsfP1SyWyx1NnU+atMMtwLNfyEyXIO6nKjx0RR+9R9pWJDCxwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ohbx3Ig9z23TcoeMZrspJpYnLJsnWzy6p3a5v/NiZ58=;
	b=gnz99MvofS5LJQzFVf1SHTXHFe9anCX6GTXVWA8+cvh5ttoMVS7obuI3GL9FZe1p9det
	 fiRmNpY4kstFXurPlpWrMx3XEqcn+ThxWZY89mFeVk7HNE0tKcRWyb6nOz1eAEwhHTMo5
	 0ejFXIZiy51bq/eCBfQHvhz7BSYWrPFaRYaCbIeUTNbKzOeL8lvkbLsPYw09mDYc5Fv2x
	 vpRI41VKt6cVgfLcMJvCKJWhcQGeR1WAl8ygqC6Ah1BC6o4v3jh4y/f4Xdq5xzjZzxCiF
	 HmdfYSBHvF1TIVdw24rmLW5/Gm43YP3/DP7h/t7XMi0s8bjcFHhYr1Uo8xTSwgSV7Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nke7FdKR;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86697606A338
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86697606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nke7FdKR
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so245249a12.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 20:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938296; x=1794543096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ohbx3Ig9z23TcoeMZrspJpYnLJsnWzy6p3a5v/NiZ58=;
        b=Nke7FdKRKIYANwrvp+6uoQaNApgSrQnLeOaQdCwROv6gzM3vnNyFmEW9e0Xu9Odzvr
         qL8104lHFVOihtenk8ovQ65GvQpZDai68CSn8sQECniqE9h6p5iZWr5MHp79kk9Etchc
         MC4sTCdyck7K7x9or1+mm+J/0toQEQCe6fMe+Df67BGihaaKDODYjy2eJy6jzK7PIf2L
         6CQfDhcBus5YDr14IKvaWnb0DLS/O34Vv+u2h/nv2BBhGv7tFW/rf0Ktx/U3ldge6yaz
         kqp0b56HcA9kFKs4rI+JDMOPh4mV//bAX/mFy9nQXNH4P6/g6o4gwrz3R+ZZiaVCnB//
         FhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938296; x=1794543096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ohbx3Ig9z23TcoeMZrspJpYnLJsnWzy6p3a5v/NiZ58=;
        b=oeHO6vZzqTIsumrPEAGQh54AhtFuFBoeXwnQ2Kzm071lRmZGfsEsGDqrsfyoNskSKS
         MybGQJ3q+Y8DT4djKO2Cp6chBtUrzRdmUikY93eYUpc98rsNPITMSLJqkaikdws0FjG/
         EI4E3SlfC3WT6F6fnxPJ2PONaoTWK+7Cf5Asx+Sz8P8SvZ+fOI+vR5GhqWt57UZpeVWo
         j7By/0s4OHOoZRlAVL6XKeBSCEk616R4/yx5Zv7sfAS2PkPZlYosa3OslYByfUzzblxJ
         Vo9JSt5/4zMZ2eJRbP000pogY00wOKTElYD1jFgsH8IR+DcMrn+Ts65IFG1qafvYEjvi
         q8wA==
X-Forwarded-Encrypted: i=1; AKwUvBz6QXZzWCPPux9jRP8vloZcIWT23PiVJiaM6WZmvckDeoKwJA3+A5vL3y2Sn9c7WV0WxnFYwqI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5CPzEdp+WS2bpXaIU8oser7uN4pXcm1WcFwfBi73Fpr3+evnc
	VCfRsQxgS79bKhFrMJ/6i1YZscIvM0H8lboko1z5vKa0WE00Q1YxgaIc0YtJShqw
X-Gm-Gg: AYBFou0MISLKp9ACrMIiOnz//DRlCf/blvzLpJ/97qdVxbF5G3mdmX5HK7wRrmYiDkq
	EHQwN5o4/5OLbvDOpObyY0EwMOLsueUmmsP4RgpMotAWeA2gLXZaKkWOvsegb7IPxxdAuiAC6zV
	sqq1r2dQhzs5YFNEObeiOpDlIQpvKfECAThltAVAWYb7MyVorNQFa6hL3wxWUNVIqn89g/WaBw0
	4uQj73/mSAlqoxSYI585WVwqOKOlNf+jCYKjak9uvVRuW7ftOyYrux0qmJaF7zlP9RIeQLA8HA3
	5j2xrZAUdFDBs8OVf/t6fiaxn7rtYyaI86gJcKKfbQfa3OTPsAY0lLJyEtJKTAiZmYXDFlvgVpI
	MkecmVlBtnpEv8l8WQX3zIU9C/gAeORYvtRCAPG/k6/x808z1OG49mObDHF3XvxLkW0n5Drmpyt
	k66xBbkNt+HPRxfBOHnCu4okCjWnU7CLiZ+drPLEVBkw9OmzSO5hPkzl4XzGu3+EnFkaKTyDV2+
	1AsW7Fu/jr+0u2vrpeFH+j1CxZDVuNrWSXGazUSYb3EGrA+cM85KTyLLqznXUA2J81wDGBQMLLw
	q0W9S+iS5GdbgaaYM839eu2VUWz+LBc+ojjOsuhCi8kE8KwpJlRW6jh7JxDoV72DcjiYSGi0v61
	SztZiNr+NIij9
X-Received: by 2002:a17:907:d649:b0:c40:38b5:d784 with SMTP id a640c23a62f3a-c4d34bdd04amr110673866b.22.1793938295851;
        Thu, 05 Nov 2026 20:11:35 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356e58c7sm41723066b.78.2026.11.05.20.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:11:35 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.12 3/3] ovl: do not copy up a dentry that was removed
Date: Fri,  6 Nov 2026 05:11:25 +0100
Message-ID: <20261106041128.3797453-6-amir73il@gmail.com>
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
@@ -828,7 +828,14 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
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

