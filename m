Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938301;
	b=Me8hqYTUaQhZQKhKUANfGTSaJbqsKLjYUyqawUUY+ynjy92YudgHlsPxGFvtdCaE3+Rh
	 JAg1HTeLPhtOshUwcssTHL7Zqu5fT/r9rcnm6YIIB1QUGqbVRBaA2URlkL913sIr5XpmW
	 Pv/eA1kR48iEjXrLDLFrAKZRsz1DbZ5LHekJUrvEU3BhCI4V1Dmpt6YW1L4ExAbFL9jlj
	 3E6nGdRCSFnU458z0WmLE/qpwo1jSfao6vvEIXmOEIWOUqucp3HvT2c51sXbwyh8vu43I
	 8kqjxu1lfvNG8bjguaIAnyVfkiGG2FEhzUHJhYCjOwe7SCTC8E+zw1AggHM7I8zOd1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NIgE2uQWtYxTbhtqb99xSrhaMp7sX/IVRuUE2g9SjPw=;
	b=q5IiMRxAQqI6d9cigmwohknZDbviigGn3kv/8V37E287OTupV7GcEU3Xq+glIYA77dFj
	 8pUDjNLocdVBcM7VrlGmVLx467IsKy35QpKiYQEUBgYeaIpPwCYFXnGcg7MYqcVacO60H
	 vPyi8jwPMJWTE0vpY304ZmTMLWq6+8AmvF3JhNe8hbrT5Fy0Y637QYSRGFFIuJfgI09Wl
	 8aFUTgjDh9XX0t/slvluS0p/+IVFngZKiuiBQ6qNG9vY3vn3jXekhr7LCaq/dRIg2PvJZ
	 RR231vrEPBHSIn+4ykQ921CbXJWnniFxsOEZoAAT1xmoIYpiYOH+F1/AhtnZyaqutVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UHNCz6O7;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B44606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92B44606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UHNCz6O7
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c49b431f022so27433766b.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 20:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938300; x=1794543100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NIgE2uQWtYxTbhtqb99xSrhaMp7sX/IVRuUE2g9SjPw=;
        b=UHNCz6O7Vn34MTlJt1HM6eGcVP31ROlm2tiCpDJx8xgm/jeoBT0fyuJ4cXkFnBfgOR
         3ji/WbQi6blXKCPbtr4pRth4QZyZqF6eeadi2xHFq4fyVq2tNTyS8LdNDZPQfMZ17YVF
         xn6puwFawiDjmuRWF4PAmY4Qkg2r4aPAuts/X9aTixQidrbVBIJwlj23l2NyB71TIp39
         EoVhi5Bsp83+iJ+sLNvpF3w+NrQnFjNneuR+NWkGyFng1B3LsZkKZZf2yQnpYrfzh65Y
         NbgGbe+okOaLsJgk+ohENV66s+SKFksFdbTiFaVf5VotU0TON52bfqMjnptFExHS3eP2
         efBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938300; x=1794543100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NIgE2uQWtYxTbhtqb99xSrhaMp7sX/IVRuUE2g9SjPw=;
        b=XgRnDdJQQ404kf1O7dMoyfCYl5q237zoDzy1s/dFkQCWBEsDBXesir/nhxBzQl1L82
         Hr4xAvB/YkJ0bnwbr7xdqzK+UicWWViQt77Lj+GnZyzowJt1tgewGThilUzOZNEHTCBm
         MObCLQlO100EvGi/2QHWvMiBuUwrVF8fgvEO3TXKWfnKIpCcbXwFSL/QXfJ+gLPaWMVq
         YbDI+UMq4w+v8mSrZ6IGjsb3//vky117X7yB7+jxdt79PWobhhvvtc55Jy5kSnjqCmxP
         9KnNyzcVuU9d8QotVxRmyhqn2wSiqgw6rom6IX0C6v+emXY+evH/RY4i3rnppmdS1V4U
         Cwzg==
X-Forwarded-Encrypted: i=1; AKwUvBwFwA46bNV34OhtAae00R8ZY5Jj0geD4Ff5R4m0bwWTBdhKof+C+V1i2EKfOpBuXn3vb5ffvJo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/d6MtXdAvCPNgZf7hU8uOqwv8EmDBazt7FoaZW/BlNwLHNhoYZ
	Bplyc0ESveZfd/G/stbFpMd4DR1xhn2whYyrg7+aVDwq7ELK3QNA9mluoqqRYv3i
X-Gm-Gg: AYBFou0ogr3Us469V1TDo9pCgwi6+EfmuWBDv8zRsWfXAKQX3zXQcepBiCOg7pmj+Km
	oALjHqHvz8QQ4c8jymj9SJXfzq+muDjUvdBMkZU1HH9Fu8LShdJpWOVl4miVh8OUBnyK//l1Az/
	1YUw0Qj1WyJh6iHi/8EtTh2MM7tIR6Ct+ljiwE8j8uiv1DCUXk4wXvXx6RbOlFhgtvAig4+7K9v
	tzJ590WCn18pJPTbwfxmMvKiZKpXwe4gOtDhx4mmstWNSC1+0QqZ4jjqfg9bjCH3btT/tUagpVU
	wKnwTtDA41SVqG0yoT84Ym0gNsONJ+UdAV7Br9LtFSDHgI1fgU0vv7ZZALE7M3R2owiBTOfRVE2
	OpMeOytL0F6IBsWwWOyDltstqXZ2aElyoWs4VencW4IE1IJZmRGjAUtOKaQa2gQKv0cdrhW7nIb
	oJgeH1KuFoY1jwdO68SdLra+IRw55ALLpVZz1fVcCT1+wNMs4M7MDKb/FRbUIqKuwLib2Uwj/yu
	xDt3O+u/ITeBL740xj+cdC9umN7X+NAiQkOtZHJ5+dAFEF+IT2W1DGSCKBNaaSZU4MllEpjRAAv
	4OKAwTroA4Sr+zaJBAIhXMCxYD9F6iUSOeNSgtBDaqRAA1DlEWjy7nYG9L13kUeznthopznvGxv
	QRZinYX5ULr6nl3vts1VXuGP4rd6QNCrZyg==
X-Received: by 2002:a17:906:9f92:b0:c49:a408:f682 with SMTP id a640c23a62f3a-c4d34d3251amr118033766b.42.1793938299908;
        Thu, 05 Nov 2026 20:11:39 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356a4690sm41228866b.61.2026.11.05.20.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:11:39 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.6 3/3] ovl: do not copy up a dentry that was removed
Date: Fri,  6 Nov 2026 05:11:28 +0100
Message-ID: <20261106041128.3797453-9-amir73il@gmail.com>
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
@@ -759,7 +759,14 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
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

