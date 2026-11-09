Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225149;
	b=aZOuqB8sYslpPmr67EGN4ujM5BeB88ZjzZLF7qHl9kTCmJQ6HQ+l2Ef89+CTe/okNAXy
	 ZAAQYIxhXPnj0TuEA1KtrYaKdGJRLxb4zLKQtEEUi3WNLivdCXbCIxu/2aqvqeMuNy+qe
	 mt/lS8V3MYE85ZXgsJTn0MPa0iqL0iK9YhQmAFZq6O+qHNlSYUOTLBTuw7XC8C6WJ5j5G
	 aMPS20T/vjh+JRIuzfj1pd4l35ZRLTT6i4mgbU9oEWsAd1vEuGmfvY6+0d0yMixJfH+ZN
	 DO/kOv8DA/i8a0LpZUSYXtged1k+mL293lzPJMshV9e30mDB1YIhQVzgt+72rEQUb7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U2EoyYDK7Cd8CqerOesnBjtnC3+XQJwuHrS5Rz0SBio=;
	b=NQVajVMYTmMWtse9f0ua4ufdQgGDBfYektqAf9AwKNYqEFh5ABkJTnjdLNqzt+BrrTuu
	 5l7zbhYecCtYmz8gTtTRQ0e/Ve/umZnfX4Qih/GGlqwW4nzZYk6gEpDCjETfripkHTeQW
	 HPhSlh7H8Q5vw3ZHXt7va3y6x3NyTylXy2FRz1rYiA5IQBvMWjo3FAZo6x7fNRx3sgHBc
	 1MBnVE0/rNdWrlQH/0TAHVh4uDDs7oS/9tPXXZA74T2uVPEwAfBvF8sOzkwRwDYohxEJx
	 0w1JLKxonjpYzrmYc+TgxVa9btze0BC2vKEhb7O/h/khuxSYNbQssUMIILwBaDyzBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iZmZGX6F;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E32606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 11:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04E32606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iZmZGX6F
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4697404c2bso95903866b.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 03:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794225147; x=1794829947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U2EoyYDK7Cd8CqerOesnBjtnC3+XQJwuHrS5Rz0SBio=;
        b=iZmZGX6FLxDh4pH7C+bq0omojsZes7VEq8qQ6bGXhXod6BPJ99BYYrKvDIFQW+24KN
         J/kc5oMK+F3oYqNGQ+U8mmHyJ3biR5VJFxeFl2m6IWjs5uLEPSHJEJ/8ewsaXRylhCOJ
         r8UoXDeYhNbMcpKUyXizGymMVdKyAz33Ulg1QRpdLPAv1HG9R0+4n79rgLwIWxqVgygF
         JW/mOoMg9Ng6b2HPAsV6QNgl6eX0V5C77x6bk5y40yjeeSByskCMJNy4zpEUgR5n4ZQU
         q+5BARnthJRH81+1UBmoZkZJCZUNjOujTZTn70yTkgNba+Ck8QrzUXCbN2UYq4j+jrM7
         pPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794225147; x=1794829947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U2EoyYDK7Cd8CqerOesnBjtnC3+XQJwuHrS5Rz0SBio=;
        b=lXPJX7My4oixkpDRKCofpbtEuf2dzaf83aPNc+sJB800aLYAR4j0zdYRy9aSFoIg9O
         yA2i/vxKnvPxNh0AKJ7HaBKynjyfR6tob5zeNnWq+cpL+PGr06Qxhn8o35hbnSQDfOha
         fMRrRyjd+l38tgs3wzkRLNGv5bjcGs0Q8PnR9Bt9f8zVjWiJIbUFCKRmILoOnaGAOcem
         eniwOzFrdMtkxRdCtbfilHvkfVAEiFptf+zMSRMOcxtI0Go1Tiw3U7d8lT206kOGMBcp
         Fb5opT5nw1m17iZj29IxW9hZqb5+ohyMPDi8BBMClNe00R8aKjSajWvHt0+YYG0sui31
         p/6A==
X-Forwarded-Encrypted: i=1; AL+hErEE0LSsFkfEL0nhqmOKfKqbIED0LNxETzwfhUz9sjS3/0ykJLDElaPTp9rp5fxs8uKFNjnccPk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hSlRJnj9I3Cgg2QNjlG4sOf+biOszFj8QoLPoQOVoZ8owmnys
	NUYz+1xH2+cKQ6cYRA2b39sUjo0eGSC0GbXWm1izg6GKL/k2FT83O/R3/hYEhYi3
X-Gm-Gg: AYBFou2E5cW5mUeW/P+xx7jIEM4pGqdJNj4CKq7QHseMsa5xVc9v7y9/NWLRqDPDpG+
	9b+5Vl9pA1NUcd4r9Z+6P3z21YbLehE20FxvbSzGtfNCh39lZ/ODWusbJqE0vQP2NN57znclv9C
	2ZurTqBat69CIJm3fMoESxVJaf7tocnZCiEdyeLEmH1dEWwvxI0WoeNCKbYtRQLavaF8r7PhGjP
	q5TDLVtpRvlihONecX8M8108jjZ3Bob/2qgwRPQ0AaLzEXJr+HD7GjXcBOlOotlS0S9fiF5agcY
	rCM7XHbCAq3Bm2OseMk+FpbSo4lk4osFObEi08+NfruxNh6HAck6ySKFJrvfi6o7CtGig9XzGFS
	qoY1ytYbW8skqnUouQNHzJx81im0o2FIzOdExQHmV8bp/5WiTeKL+gtVu0LcuiK/FUR7XTYAgd2
	s8hsmAk9/jndTLPjvlEXxtQ0601/v82MamENQN3FZ4mlDdBRuh9HaINE5gHJXws+Lo+PCyq/g4U
	LKZ8q0qxvfF/EAGDwizHLZ0+MHA7SvIllkJ5S5h9pt9zow0TP7o2vw0OEegbeEt590mosgyw5JR
	wuh5lFZzZ20f17R9LGIFAy9I3I1jJFUkUNvVv2iTaXffHUBA9SkEB/z5/Gd7fG9Ds4NR865/c2g
	KsfGabbm4xaen
X-Received: by 2002:a17:907:3d0e:b0:c2e:61e:f4fd with SMTP id a640c23a62f3a-c4d6da63193mr273957266b.5.1794225147191;
        Mon, 09 Nov 2026 03:52:27 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ea368csm1382016a12.10.2026.11.09.03.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:52:26 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Giuseppe Scrivano <giuseppe@scrivano.org>,
	linux-unionfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ovl: report the requested redirect_dir mode in conflicting options
Date: Mon,  9 Nov 2026 12:52:26 +0100
Message-ID: <20261109115226.4031954-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Since the redirect_dir mode is stored as an enum, "off" is translated to
"follow" or "nofollow" when parsing the option and redirect_dir=follow is
translated to "on" for a non-upper mount, so the errors about options
that conflict with an explicit redirect_dir= report a mode that the user
did not request.

Translate "off" when verifying the mount options instead of when parsing
them and report the requested mode in those errors.

Fixes: af5f2396b671 ("ovl: store enum redirect_mode in config instead of a string")
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/overlayfs.h | 10 +++++++---
 fs/overlayfs/params.c    | 43 ++++++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index d1ced6d07f1e4..2c65056ae9361 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -76,9 +76,13 @@ enum ovl_entry_flag {
 };
 
 enum {
-	OVL_REDIRECT_OFF,	/* "off" mode is never used. In effect	*/
-	OVL_REDIRECT_FOLLOW,	/* ...it translates to either "follow"	*/
-	OVL_REDIRECT_NOFOLLOW,	/* ...or "nofollow".			*/
+	/*
+	 * "off" mode is never used after mount options are verified. In effect
+	 * it translates to either "follow" or "nofollow".
+	 */
+	OVL_REDIRECT_OFF,
+	OVL_REDIRECT_FOLLOW,
+	OVL_REDIRECT_NOFOLLOW,
 	OVL_REDIRECT_ON,
 };
 
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 7a4e1be5225fa..27ef3b0651e2a 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -112,18 +112,28 @@ const struct constant_table ovl_parameter_redirect_dir[] = {
 	{}
 };
 
+static const char *ovl_redirect_mode_name(int redirect_mode)
+{
+	return ovl_parameter_redirect_dir[redirect_mode].name;
+}
+
 static const char *ovl_redirect_mode(struct ovl_config *config)
 {
-	return ovl_parameter_redirect_dir[config->redirect_mode].name;
+	return ovl_redirect_mode_name(config->redirect_mode);
 }
 
-static int ovl_redirect_mode_def(void)
+static int ovl_redirect_follow_mode(void)
 {
-	return ovl_redirect_dir_def	  ? OVL_REDIRECT_ON :
-	       ovl_redirect_always_follow ? OVL_REDIRECT_FOLLOW :
+	return ovl_redirect_always_follow ? OVL_REDIRECT_FOLLOW :
 					    OVL_REDIRECT_NOFOLLOW;
 }
 
+static int ovl_redirect_mode_def(void)
+{
+	return ovl_redirect_dir_def ? OVL_REDIRECT_ON :
+				      ovl_redirect_follow_mode();
+}
+
 static const struct constant_table ovl_parameter_verity[] = {
 	{ "off",	OVL_VERITY_OFF     },
 	{ "on",		OVL_VERITY_ON      },
@@ -659,11 +669,6 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_redirect_dir:
 		config->redirect_mode = result.uint_32;
-		if (config->redirect_mode == OVL_REDIRECT_OFF) {
-			config->redirect_mode = ovl_redirect_always_follow ?
-						OVL_REDIRECT_FOLLOW :
-						OVL_REDIRECT_NOFOLLOW;
-		}
 		ctx->set.redirect = true;
 		break;
 	case Opt_index:
@@ -819,7 +824,13 @@ int ovl_init_fs_context(struct fs_context *fc)
 	if (!ofs)
 		goto out_err;
 
-	ofs->config.redirect_mode	= ovl_redirect_mode_def();
+	/*
+	 * The module default determines only if new redirects are created in
+	 * upper dir.  If they are not, the redirect follow mode will be
+	 * determined after parsing mount options.
+	 */
+	ofs->config.redirect_mode	= ovl_redirect_dir_def ?
+					  OVL_REDIRECT_ON : OVL_REDIRECT_OFF;
 	ofs->config.index		= ovl_index_def;
 	ofs->config.uuid		= ovl_uuid_def();
 	ofs->config.nfs_export		= ovl_nfs_export_def;
@@ -877,6 +888,8 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 			 struct ovl_config *config)
 {
 	struct ovl_opt_set set = ctx->set;
+	/* The requested redirect_dir=, for reporting conflicts with it */
+	int redirect_opt = config->redirect_mode;
 
 	/* Workdir/index are useless in non-upper mount */
 	if (!config->upperdir) {
@@ -903,6 +916,10 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 		config->uuid = OVL_UUID_NULL;
 	}
 
+	/* Resolve redirect_dir=off to the default redirect follow mode */
+	if (config->redirect_mode == OVL_REDIRECT_OFF)
+		config->redirect_mode = ovl_redirect_follow_mode();
+
 	/*
 	 * This is to make the logic below simpler.  It doesn't make any other
 	 * difference, since redirect_dir=on is only used for upper.
@@ -914,7 +931,7 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 	if (config->metacopy && config->redirect_mode != OVL_REDIRECT_ON) {
 		if (set.metacopy && set.redirect) {
 			pr_err("conflicting options: metacopy=on,redirect_dir=%s\n",
-			       ovl_redirect_mode(config));
+			       ovl_redirect_mode_name(redirect_opt));
 			return -EINVAL;
 		}
 		if (set.redirect) {
@@ -923,7 +940,7 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 			 * in this conflict.
 			 */
 			pr_info("disabling metacopy due to redirect_dir=%s\n",
-				ovl_redirect_mode(config));
+				ovl_redirect_mode_name(redirect_opt));
 			config->metacopy = false;
 		} else {
 			/* Automatically enable redirect otherwise. */
@@ -1000,7 +1017,7 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 		if (set.redirect &&
 		    config->redirect_mode != OVL_REDIRECT_NOFOLLOW) {
 			pr_err("conflicting options: userxattr,redirect_dir=%s\n",
-			       ovl_redirect_mode(config));
+			       ovl_redirect_mode_name(redirect_opt));
 			return -EINVAL;
 		}
 		if (config->metacopy && set.metacopy) {
-- 
2.56.0

