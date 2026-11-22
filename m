Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343337;
	b=IhK+RVlIkOeTzjNb6L3zSSHfR/Mkkc4eV0Y3UMggDW8ufushkjnuhVBGpajVnPq1jiwI
	 Tgy97s2pOaEwfPYrqM66DCCtixLAM0T/SBh2EM8rl1w4tIZrtd1a6Y5OJmgXiAw1n9Zzm
	 czvK3aMenm9ut1Fhg4TQ4O3ATg3+uKQ3OoRIgGd9QpxPV7nATm4jQD+IPQKXhN03bAcki
	 tkHqOYmxdD5p/UwIR2y3FKHt/k2S2LNSsSaM13HPxlEmZVyzRaXzOeRRuVlP6b3hPhnFt
	 f/0oZ4lCcZBBXvmg+6DSbIOVkiZhcgFWbboMGaLxmN7Rd2ch0pPnwG4AZk0yn8cw+lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RZ0O0POJrr0conSKv7mDqlSwmUjcS392Zlp+KvMCf14=;
	b=q7g9RfL3AnywAguAElZt1EuNMPU1xxMjPaIa0B2ZOpUozCJM76p0G/u9T5VpDSXxlKvA
	 vRL99rhs1LHjHmftjcArR+d5ulS50+pP2ZYGxhXjFFVlDBH1WfuOH+ueMPwHY7H/V3+r8
	 CTHTXx04wKxjm8/vHtSJh/vcf/e+lGYWVis+n6cpeTPDrt3lwdk2lj/Ro7CNI2uGIOGic
	 z5wzjL3WkP5LLagAcWD+ljWYMvyfS7SwtAskpQfdzVsBlB3oOwkUZSuQXfAZawkH6nXdU
	 Z2Rh/+q1SUgPBh7BlTgylbTzcuCRkriXk0ByIK1H/J9G/7lnKTYEWnJv3PNtFP64Jlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U5SErA4S;
	arc=none smtp.remote-ip=74.125.228.138
Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F1606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 10:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A2F1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U5SErA4S
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c4077bca4a6so100807366b.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 02:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795343335; x=1795948135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RZ0O0POJrr0conSKv7mDqlSwmUjcS392Zlp+KvMCf14=;
        b=U5SErA4SKPMPlUUC8Hpj3tgK14H8t3haFRITvCal7hWmO1uQCJM23eL2NKSL+3abov
         t3Ga8hZjRhzvVJ9cbw4Vb7N1YpXch3MGgNvwtd0JFW9deXQsvKqE0TwaJazOc4dRIvu1
         A+bpYcoM/yNfmL4mNx+lNMVLOZqXuHsJKuyfndLRis90ncrcwXqJJTV/cR+xrjDTftiT
         uwHZqkkDG46HnkkpVn7osItNtMa00RW43rY6JIT9X89ugjEeOZaSyccC/Q6GDKYy2Px0
         USA7CviCcfLYoNdig0G51EYTgKP8yj4hbHGLxU06uv1f22bnjpU2zE7+sMkZ45gH9eUJ
         5Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343335; x=1795948135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RZ0O0POJrr0conSKv7mDqlSwmUjcS392Zlp+KvMCf14=;
        b=mIpNw4ZiD7yaOsNy54gfqSej6pwrpGcnZHEqHKouPq3aPMnkGcWv5dzEPi+2+KxRLy
         /85AhBfzvDFKFXUUSKVFvOaujqkiTn7qGz/Hd3UWhTM/avNEvvVVnPgEAoEjvzZoOd+Q
         TfggnPhg54JwHGFEfSPMsh/tCSX/5oV69MA7iSWogxRB4LRf+tAlTOMHA3sM1y5IcNIt
         R68iz3uq/ostagIUUy776E5/IYQuP43fH736HUgupzfpjfp7Htb2Csk1RHEzfU6agzHC
         5e7selRElwxfx52dz12Qnh6aKfBjTHpN8dOnDHtlEGnE9/XZ68T2bvSjIsXSzLUXt0Rw
         Rj4Q==
X-Forwarded-Encrypted: i=1; AL+hErF857OOzpf0AqRGXewKMKsMGJKiy3edF+eGUJrjfXF5rg1ORxj3IfWuIL+pm+DtYde0u2Vz7I0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/m1A9GJdPFGHlY1YtzgHPbet+Ne19exYVlNDmjRvyNBZSm0WPu
	LGQKoq3CmU0OnyJ3VPjejETmxxxJOeBNhvzaJVe88d872LauwmE4gXE=
X-Gm-Gg: AZFdTZfjqgXD+b6htg+/2W8Xa6EZvIMFRPvJzk0uNwf0Oal2Ms197RhscB3otsjv/5s
	DNQRG+QDFBOgr/epiLRf290XSmV6RAIfKlJl+uPjvMhbYeX2mGBoCpjG9491vk8e7xk+AVnqKBn
	Vfz9AJiJxRLsqg27fo3s22BcOxLCSVk432DxLsPguv3mvZtlXxtCule6edRh7oXrda1Xtbslt8b
	zzdFXWJC5NXMbuBfbZndp2elZM/j6kI6wtAfHjfTJSkqVFz6a7r0KmkEvybqjbDCfnYCPOL73yS
	ly6h3cGR0KqXNpMopzirzjqHQaO9CD622he+c//ZSeBGBePGyk/luTwxBFLFdEBpCALJJaOEodL
	s51qEVri5P7Xwhu0wGp/nMKFdm8CAA/RZ5VecVLD9tpwgyDmfPvVIO/vWj2l6Fs4ZSISNQvANqs
	TwtIk6gECjrUxVu9LLgGfAZHf11aF+sbGgPTfXAfjAo09BgWEYPoBeJ1vPkDTmjtJNgv38+lqgi
	6u1skdjIMTd67kaVcRrApB52/4kHFXGNK0APTy8qcy9w+TCZS3E/1TsbLz68MUfGjs3uXw+2qIU
	nc+NmM4HMOXcGncsmNHLz78BktbSHintaJ0AlQ8LIZUo
X-Received: by 2002:a17:906:5ac5:b0:c46:b9b0:8e8f with SMTP id a640c23a62f3a-c513ab1303fmr511361966b.41.1795343334777;
        Sun, 22 Nov 2026 02:28:54 -0800 (PST)
Received: from llm-01.drunkbatya.int ([80.251.127.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b022b2bsm295252466b.83.2026.11.22.02.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:28:54 -0800 (PST)
From: Max Andreev <drunkbatya.js@gmail.com>
To: Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kyle Tso <kyletso@google.com>
Cc: Max Andreev <drunkbatya.js@gmail.com>,
	stable@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: tcpm: fix missed frs_sourcing_vbus() call during FRS
Date: Sun, 22 Nov 2026 10:28:38 +0000
Message-ID: <20261122102839.2902079-1-drunkbatya.js@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Since commit 0908c5aca31e ("usb: typec: tcpm: AMS and Collision
Avoidance") the TCPC reports sourcing vbus while the port is still in
AMS_START with FR_SWAP_SEND as the upcoming state. Because of
_tcpm_pd_vbus_on() ignores this state, frs_sourcing_vbus() is never called
during FRS.

On Pixel 11 Pro XL after an FRS from sink to source the phone keeps
showing the charging indicator, and about 20 seconds later VBUS drops
and the attached device reboots.

Call frs_sourcing_vbus() from AMS_START when the upcoming state is
FR_SWAP_SEND.

---
I'm not test theese changes on mainline, but tested on Pixel 11 Pro XL
vendor kernel 6.1 with the same _tcpm_pd_vbus_on() code, as i see
mainline tcpm.c is identical in this area.

Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
Cc: stable@vger.kernel.org
Signed-off-by: Max Andreev <drunkbatya.js@gmail.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 51e5c72799f2..5caa649a92f1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6889,6 +6889,11 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
 			port->tcpc->frs_sourcing_vbus(port->tcpc);
 		tcpm_set_state(port, FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED, 0);
 		break;
+	case AMS_START:
+		if (port->upcoming_state == FR_SWAP_SEND &&
+		    port->tcpc->frs_sourcing_vbus)
+			port->tcpc->frs_sourcing_vbus(port->tcpc);
+		break;
 
 	case PORT_RESET:
 	case PORT_RESET_WAIT_OFF:
-- 
2.47.3

