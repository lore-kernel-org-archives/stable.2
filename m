Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602919;
	b=MC8oteKsi3NV4hJpB35sXJmTjz7xBnUCe9v8BnlEU/8oZvqoBTwlGgcgDH0rHFT1Nfid
	 nNUfKZZtxpfxOyBTHP97TGZe8RGambqZD1x+a/aW4GEsJvVdu0SI3IKKEzOUNaRE4qXu3
	 jqR+VIglhtijaPzfhf1/yNbBkKlbx+SNOzWKE5+SedrzT5NGXKZs15/B+fU6BqQmSQSNk
	 wLitFRtiwosOKcsWbBWx4jbkLW3k58BFJcSXsbtzkZjBS2I9Da/IP3AWDIvnfIdzUqWql
	 +WTErvFYFsFjl07e7dXsXJB3sFTid3du9cjHLq2kFtYc5chlly6QNPQu8mOMBPRM5Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602919;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=b6FP5LE6OUrOpQgQ1FGB91ZIJelnMj7KievGdFDFQiI=;
	b=pNJkZFFyhdBIp6qUbStFy5nmIypG/5ZxtPsB7fnompT193OX0NYgGbRoVQaN2XAadhIn
	 Es25H9WBoTIG4LK5JfvrZr8/mVcJ/uq9uRmDLD6p1658pDneFwZvCzFYlkGzTjJKPJur3
	 EARznYTjfCdoXtYXHIJ+97iKTju6XB6OnVQlz1kRPkJaa9DSc7k6WSHsL4KCffLt3i1rE
	 HFzbTLgWZcJT/wDVb+O5HMi5HhGmLmm/Q7K2vrGsWNpJelEFO+o6FbK7Hmh2P/DXd9tpA
	 AL8ymL2Tn4g3CTYs1C6ODmFXDPcHxk1DTh+JgBb6vZGc+X97j+UdIsipjhpQ1dITa4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oEO8h7PJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29424606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oEO8h7PJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2351F000F2;
	Wed, 25 Nov 2026 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602918;
	bh=b6FP5LE6OUrOpQgQ1FGB91ZIJelnMj7KievGdFDFQiI=;
	h=Subject:To:Cc:From:Date;
	b=oEO8h7PJcCTQhGSy+Igq3Pv4W7IEZXbQ7Td+Mdrq3ajcwqGmtqpzr4NTHACQyH/QR
	 dQbFYCbXnvt0aJM2enT7szS2UW9yWjNkXcQ3SnMSnrzYfiZpl3ZwJ64UimGYJtpFPz
	 m/tr54xMw7QLkZcHqG4YLomVBmvh4i4oS+GD1sy8=
Subject: FAILED: patch "[PATCH] hwmon: (nct6775) Handle dual use registers" failed to apply to 5.15-stable tree
To: glance@ac2.se,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:18:09 +0100
Message-ID: <2026112509-afraid-taste-e69d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ca1abdd1a9b9ce51713a18c8905bf10579533c3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112509-afraid-taste-e69d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca1abdd1a9b9ce51713a18c8905bf10579533c3b Mon Sep 17 00:00:00 2001
From: Anton Lundin <glance@ac2.se>
Date: Mon, 9 Nov 2026 09:25:09 +0100
Subject: [PATCH] hwmon: (nct6775) Handle dual use registers

The REG_TARGET register has different meaning, depending on if pwm is in
thermal_cruise or speed_cruise.

This means we can't assume it's always word sized, so we need to handle
it differently depending on which mode we're in.

The code already does this, but the register was configured as word
sized for the speed_cruise mode, which would do the wrong thing in
thermal_cruise mode.

Fixes: 6c009501ff20 ("hwmon: (nct6775) Add support for NCT6102D/6106D")
Fixes: 29c7cb485b32 ("hwmon: (nct6775) Integrate new model nct6116")
Fixes: 437b3c2a4bdc ("hwmon: (nct6775) Add support for NCT6126D")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Lundin <glance@ac2.se>
Link: https://patch.msgid.link/20261109082511.851377-2-glance@ac2.se
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 6e97e4f08b90..3515a962adac 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -1188,15 +1188,13 @@ bool nct6775_reg_is_word_sized(struct nct6775_data *data, u16 reg)
 	case nct6106:
 		return reg == 0x20 || reg == 0x22 || reg == 0x24 ||
 		  (reg >= 0x59 && reg < 0x69 && (reg & 1)) ||
-		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4 ||
-		  reg == 0x111 || reg == 0x121 || reg == 0x131;
+		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4;
 	case nct6116:
 	case nct6126:
 		return reg == 0x20 || reg == 0x22 || reg == 0x24 ||
 		  reg == 0x26 || reg == 0x28 || reg == 0x59 || reg == 0x5b ||
 		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4 || reg == 0xe6 ||
-		  reg == 0xe8 || reg == 0x111 || reg == 0x121 || reg == 0x131 ||
-		  reg == 0x191 || reg == 0x1a1;
+		  reg == 0xe8;
 	case nct6775:
 		return (((reg & 0xff00) == 0x100 ||
 		    (reg & 0xff00) == 0x200) &&

