Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602913;
	b=lCsAL2W++g9BmiFZqhH8Zzm7rLHvlFfv3C8yWFGO+DBn2yZr69yLbhf2ZG5dNjP/ORIk
	 AKIhQRxNbIWnxHAbhtVbbZVMkF5v/uXoEEKlJDr4FCA7KiKK441gnx/56Ou1PLiFMLUnW
	 u2Yuo9pKV22mr6WsEbo5pOMh8BbK0WY+UxstAilfeEZ3QEJqOtGqo9K9nPnDrDiEULJxZ
	 IuQ6CuRJBNYQb6wne9Rfu6Mq/+rap6k6KqHC35lgLRRXc7Mhzgxu2aZgOPOh1Sz9Ng3Q0
	 YcItykEwDnHmHfBVSBLpKLsoxVw2p0o2MBwdDAhZh0yO+t8Z75ka8QfyG50O61wH9ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602913;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5iGTWoKOK+7uprPdVC4ERqqtTbMquJpp5m1qNfbSQUk=;
	b=Ve6XogGO0rYWwyGunykrf7CFePMjdfF+pwcU+M+CBNox6irb/EW7LkQjHC7BKd7v0lPd
	 FAxckeUMEvThftqQBu6fzhxJ6Q0HqwwsHFLY/mlf6PHreB8AhS/SPXur2NTRXcA4qHPXn
	 WoF+XATIupV7AqK5O11+ohuybC5DPxblNCjoEYkk7vo/uhgxUZD4Jr5gZMUMk/nnPVZO4
	 P15HB6N1J7Qhl2QutqXht27zNu1+qI2AcX0rLz0s5dFJfAXNrlIssS0s1lce6NEBgBKtF
	 ZvgaYiruiCB10wy5sqMGv6ww4juw1E40nEUtxuBr7qws6j/52cOe9sRBWupw1xrYddg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kZ7cbeof;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C61606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kZ7cbeof
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA841F000C0;
	Wed, 25 Nov 2026 10:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602912;
	bh=5iGTWoKOK+7uprPdVC4ERqqtTbMquJpp5m1qNfbSQUk=;
	h=Subject:To:Cc:From:Date;
	b=kZ7cbeofcyiz/bsuoU8lD6KJB2MEnmz9+LFanUdoEwuw3JqEZMMhjY8DJRMKM5Obh
	 oGMzjEsA2WQjYG8we9FA9ieawZdGZ2j4eiiS3RCByWok5hTLFQUZDNT3Q4ccTMfL8L
	 Fv2QWk4s4uoP0UhrXARPjJZiuuigxQzQUavnMbVw=
Subject: FAILED: patch "[PATCH] hwmon: (nct6775) Handle dual use registers" failed to apply to 7.3-stable tree
To: glance@ac2.se,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:18:08 +0100
Message-ID: <2026112508-excuse-mankind-5ea0@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x ca1abdd1a9b9ce51713a18c8905bf10579533c3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112508-excuse-mankind-5ea0@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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

