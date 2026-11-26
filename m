Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685486;
	b=k75Z5VxP60JFgbzOMsfmG3XzNgvGnd1EczoCUKS955ikxtnEp2PNl1HZbVzUjlJTKP5x
	 VB/cAVDG/mJWEMcBMoCVnhluEtjEKCMFecwpUTwU1/ocXHZ8bq+NZsRxq085kxyGHeTn3
	 PTCVWiJRSE6aDUOGJkRItG19picMZefmKPVNeAcvIvbaxYmSWfXXzM0TxJqc8KxyF0G23
	 H9/J5LovvNKXQOP2mzIgsbp8YJmA3k4Dmd7LHqZWLuejuNRmcmkjZrmNHFWF5r1oda+n/
	 zPOi64XVSSZFtQh+byOu5htHIQxbaIml6jRDmjW9P8NMrXAHf8iuwKw0ZwCuOWEz3zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tCB15JnYkDvfVGEXUZ81H+2smLFpK44pjfBFb6tfg1Y=;
	b=sMr82vJsOPfPvapYlIdXy+U53moQLm7oYJbdo1Y7AD4PYQ53DXS0B26K1Xv0okvmBZTB
	 KVd+Gka8adzFEqJjSGaC6s9bBD8YybMNClWFEy3aAoYBsnWEWXozuSMcoULj+eolHe+mD
	 ytlZjZB7a08esY7MWSgFA7ZPRNNUsC7ALe4JshRHFtHUqknPh77F3HnvUEmqk0/fpdeVJ
	 lZbOi3IpxHs7oW5+SBYp6ocXVOWfUsW5wdp/3xsDto+J+Rlj3bGKYpJO3w7/L8VEz9YxT
	 cQ/Jln4bjxS5Uy9N+buBhcsHCt8jix7m2qJ73WiY0iOLAEPz1z5aVdyVFavqlYZa8ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJqwi00S;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996AF606A335
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 996AF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJqwi00S
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c5118deebcfso1008707166b.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685485; x=1796290285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tCB15JnYkDvfVGEXUZ81H+2smLFpK44pjfBFb6tfg1Y=;
        b=VJqwi00S5Wbo8E/cR2Lcr2fOeC5pr51NXyVjERokSV/kXNOsPUKew2a9XEf9JFgoMk
         c3+SV+T/13UTVvesYqXWkVTEpcDvm8S0we6zORSJTpJHVWmy+eQNXitRvmAYFDwZz/jp
         LP5xYQ5dEOLQmQtMEKTRhEb0Ba/3NGuSJY0Q4MrsKSlVTMo50lENu6l/3JSEyoVsSqC9
         klEeLq7R0FPtOPSLjHDYg7mvBMwKafcc6yqTCLc6eEhSW+LubgJTVR2Ynv2nNiA6Cbo+
         WTjJfs+LwyXTTgxE7oyG8J7xnPeuBrEppFHtQXhZXcel/Y2Cy92F1RGlr/Ff+RJvt3kp
         oKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685485; x=1796290285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tCB15JnYkDvfVGEXUZ81H+2smLFpK44pjfBFb6tfg1Y=;
        b=aoqdgNn07GjQgxdkVWXf1LvdK2pYHrM21bQLL5c20ET3ml8TOKR4gdQY5PTnS+z8nM
         nY1anQuLfa6KS9hti1dPyAFq31qc6oS9d8sJsuJvG27kqREMAXupinIkw/Ubapq0Ay5l
         Ia9HT00xVwOl5RvajIoeO6Ns0bf19fugDj82uD3H+HKQkE+/vnBHNgJuL0wpA/bYG76m
         GSI1PCTDq2MGm0DmeWteXZmpymNwtb5iWwyOtwm9egZHHS1kuKpIyn7vMBRinCrHVN6q
         1rLGHHm+6JccBi3dtQZfE6OgE04oJbLhrfEGcVBub/rqVrfXUtPIVtE4+angGUR1fv1h
         y7rQ==
X-Forwarded-Encrypted: i=1; AL+hErGghu+uJgsdpUSmes9k5yzQRhJezcMJTvcrwukQ0Dt/iQ0iFU0q+ubaYdcxqNvR19xz9KRQHXA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BqxY3s/aYRUxGnjXeQm7KlCEbCebspyzRtXr8rJiz41Q4xmg4
	LE23YBjUW9BNMe/IKDRDhAaTGhQuRxIrdw4DWfM/XpOWNXfK+QSeEtBQ
X-Gm-Gg: AZFdTZf09M21iS906ADuYPS9KNDfR/x9BJ5o/U7w37bTRUJpIXP4+33fhDbvuYBJzaO
	wUnIyPRa+AGfYSjd5aSSx2egBMDagrpl3s4LVYBX/uNcT3XJLM4S4oOc8rFI1dy6IVxJrS8Y785
	eZ5bzTWf6DT+1PBM091sqtN6mkXRgS3LS/d6Lbu/b7V6fa5C6KNWMhsV/9O7qeypifE0WVQqA+j
	eauqRbDYQtmHjLq5EekPQMqVqoXncYpACi/Ja6BsTQAPTIaC1ptwHDueTIMpiA0vchRkS55Q7mR
	64aoncxsDjK0oXRNbbshcBCegLW7VuZltMdDAfmV6x43CbKQZbq94yDn5OtDwzQPejXmLxriXoN
	dgG6p5f6v1WH7GnJVDU+zqPxVmFDDQ8ZEPtFIpaUvxqcINy9cKYUDLU+TYfoMGwR24DWbaOes2d
	pcdqeZNdfJCVxzlqVXqjascOPXBmTfP45VMyvVhBsaFVRuEBszLPEuMuHOpMp7L/RZ2cl4Ro8c5
	+ESfk8Rz7kVz7wXhTMgUGduNymnTrYWh3RVetCUkjCWFhgcXYlxYNyvyLZmDAO1/oGB2mbwCbb+
	MCRpBzi6qdcv58nEQ0rZ8s8iKiujTD/Vuny6AbmqV0vfxcA0B8OHEV65MdWW61pI4dt6b2U=
X-Received: by 2002:a17:906:ad1:b0:c2d:d408:5d9c with SMTP id a640c23a62f3a-c513ac9c0d9mr1173205266b.48.1795685484803;
        Thu, 26 Nov 2026 01:31:24 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:24 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 05/18] sparc32: preserve both LEON PROM character-output conventions
Date: Thu, 26 Nov 2026 10:30:10 +0100
Message-ID: <20261126093106.1345825-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126093106.1345825-1-linmag7@gmail.com>
References: <20261126093106.1345825-1-linmag7@gmail.com>
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

Factory GR-LEON4-ITX U-Boot returns zero after character output, while
modern MKLINUXIMG returns zero when busy and one after transmission.
Recognize the legacy PROM before printing and adapt only its zero-success
callback. Match the exact legacy properties and accept its getprop()
success value of one; preserve other firmware conventions.

Fixes: 154337688bfa ("sparc: prom: Sanitize return value from prom_nbputchar()")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/oplib_32.h |  2 ++
 arch/sparc/prom/console_32.c      |  5 +++--
 arch/sparc/prom/init_32.c         | 23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index d1cf3a27a40d..5f009615cecf 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -25,6 +25,8 @@ enum prom_major_version {
 };
 
 extern enum prom_major_version prom_vers;
+/* Old LEON U-Boot uses a blocking, zero-success V0 putchar. */
+extern bool prom_leon_legacy;
 /* Revision, and firmware revision. */
 extern unsigned int prom_rev, prom_prev;
 
diff --git a/arch/sparc/prom/console_32.c b/arch/sparc/prom/console_32.c
index 6404e5bbb7e6..8615005ca67f 100644
--- a/arch/sparc/prom/console_32.c
+++ b/arch/sparc/prom/console_32.c
@@ -22,12 +22,13 @@ extern void restore_current(void);
 static int prom_nbputchar(const char *buf)
 {
 	unsigned long flags;
-	int i = -1;
+	int i = -1, ret;
 
 	spin_lock_irqsave(&prom_lock, flags);
 	switch(prom_vers) {
 	case PROM_V0:
-		if ((*(romvec->pv_nbputchar))(*buf))
+		ret = romvec->pv_nbputchar(*buf);
+		if (prom_leon_legacy ? ret == 0 : ret)
 			i = 1;
 		break;
 	case PROM_V2:
diff --git a/arch/sparc/prom/init_32.c b/arch/sparc/prom/init_32.c
index d20470166cb1..d36fa4e7207a 100644
--- a/arch/sparc/prom/init_32.c
+++ b/arch/sparc/prom/init_32.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/string.h>
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>
@@ -19,6 +20,7 @@ EXPORT_SYMBOL(romvec);
 
 enum prom_major_version prom_vers;
 unsigned int prom_rev, prom_prev;
+bool prom_leon_legacy __ro_after_init;
 
 /* The root node of the prom device tree. */
 phandle prom_root_node;
@@ -27,6 +29,25 @@ EXPORT_SYMBOL(prom_root_node);
 /* Pointer to the device tree operations structure. */
 struct linux_nodeops *prom_nodeops;
 
+/* Identify the old U-Boot PROM before any library routine can print. */
+static void __init prom_check_legacy_leon(void)
+{
+	char compat[5] = { };
+
+	if (!IS_ENABLED(CONFIG_SPARC_LEON) || prom_vers != PROM_V0 ||
+	    romvec->pv_stdin || romvec->pv_stdout)
+		return;
+	if (prom_getproplen(prom_root_node, "compatible") >= 0)
+		return;
+	/* Old U-Boot's getprop returns one on success, not the byte count. */
+	if (prom_getproplen(prom_root_node, "compatability") != sizeof(compat))
+		return;
+	if (prom_getproperty(prom_root_node, "compatability", compat,
+			     sizeof(compat)) > 0 &&
+	    !memcmp(compat, "leon2", sizeof(compat)))
+		prom_leon_legacy = true;
+}
+
 /* You must call prom_init() before you attempt to use any of the
  * routines in the prom library.
  * It gets passed the pointer to the PROM vector.
@@ -65,6 +86,8 @@ void __init prom_init(struct linux_romvec *rp)
 	   (((unsigned long) prom_nodeops) == -1))
 		prom_halt();
 
+	prom_check_legacy_leon();
+
 	prom_meminit();
 
 	prom_ranges_init();
-- 
2.43.0

