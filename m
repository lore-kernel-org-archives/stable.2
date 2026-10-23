Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792778941;
	b=fGsb2b68+RnueWamKvnGDvJLGOT71vLNL8hqqIzhMERlc6mt+BC98c9aU1zW65gzp265
	 wfzCaCsUe1aBC+i5kLmMB8pF0bcwTMKO2lzbJVTnmZAWE9tL5z+I6529BQvLGsaDV49p3
	 RbNfOJdRfO6CPerQVfZ1UVP4ph0J7VYsEV75oH+zrZadvg5aRv+RuuUcu0gnf7d5Unwkf
	 CvcrFIgsx1ccaYikWsYht1fAvPqTtKyCfcwCoxK/1xNJWNqjc19Hovh2pI00oXK3bKZGe
	 Eqovf2Nrsu99SJPdylmKBkUlyvX0EC3bkj50zWunD08PTtsqiBdstSELKTwgox81wuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nKpQdPCfN7vtbw7obZJvLCHSgtoYzv6z5biXGbDum1g=;
	b=1ebXoNmnWss6Av7X+c53ha6Ekxt3LPsAVjyPZQBP+AY4fO/HSORJIBWO/dV2urYTGD8D
	 trL9Ok0Y5UVp1xu1fdU1ZOI0man9oTcdD2s7xUFtganJdTPzmDtgHjUv0z/BrCtQDXsma
	 QEiJzZd8Qr7HfSuMMU+0yOfL/Fw+Kmon+R2lMjWBWwG/R9t4W5rvW14o3ZAk9iDWelYmS
	 AlWB4JKnhJZWIRLDYYm4U5RbQ3EdBcyQSIs1P+mHtNJiLFrAPsZ0mpalIi/5TQ0ZiDLZx
	 xi7NoGXngfTUg28Mm7wn3wTgZFIczFsdXq9HiqdfRjogubVoyHoGxiQcjTKQTdQFSrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="V2T6l/7a";
	arc=fail smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB2C606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFB2C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V2T6l/7a
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ac65e845a8so10281821fa.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792778939; cv=none;
        d=google.com; s=arc-20260327;
        b=XDPOvTvRHP3zi0vM6vKqiv0mmJ8UyoPcTHg7irOgpb37QaR5AHsDM/GU2/LjFa1h9K
         +eEzQPzUKfCIh0rCVv+WRdiufOe4O0VZ63HmVBLefa6BhJ/QiS18ESXKpj1XWlZOQxcf
         UNQZUWGcOfqLABgyHWW6BFUlEK2lVI9AkxKRYwoZAknwHUXUNfd8cyxxJnDdCpAdm4yw
         J376/lPhr0TDMb2sia9e8TUz0mRwOo81n5Rt/q0vTCnOdyTMgFUjX9J2uCpR1bjfiwWW
         2IgzCQRb0cIjx85/uVmnC56OEV9QS8I66x7TB+ChW5Sg7bnXT/1FhhbxIpg04W8KmdRM
         ftAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nKpQdPCfN7vtbw7obZJvLCHSgtoYzv6z5biXGbDum1g=;
        fh=gJCAAvTu04pWsY0IZmXpkSTyMDATAuoQpmtCEQDvcDU=;
        b=N/rAr7YwYLXREGbkLGrvhlT5IC+hreJB9TSATIWGoBnrirhYOjWNUgez4JM5d/vUUP
         j7e5XyqGnEgAcaQEU0SPPYQQj3cjQHJ9TnAhZbsScXMmQ94tHpR2UkaA87XMJ5iaO58y
         +n5mi2QttJk/plKZw6UF0p+5i61Sej5GH8CyI0PVWdJ9N2VHi3aGDrc1GsvOMw0Q3w5k
         hEb3CBYZ99quDr+JbYhkU4mIct72ub3fWVLus75kLBdu9QZlfvcLU8UPsL2AOm7jdEs8
         CvL9owx8dX1yfZBbZ+nWLTRfyEBmHQ9hEpAYT62eRSR2coC+8q2jL85Ank9zqQCyPyWm
         oDOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778939; x=1793383739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nKpQdPCfN7vtbw7obZJvLCHSgtoYzv6z5biXGbDum1g=;
        b=V2T6l/7ameed6sVkeAzi5rrA0oehedbrCJVrRWC9j0OKhx2Zc0FICRciba4BDpIPQo
         DaoImqskD9qR6gvN9ulG9cWDahYaCipbWKqi+StdjBKSgi/XEe8DFKAaWwn66eCKp9X3
         vfIS0E+7Tjpodd69QWhWun3l0H8L4b3P/4EHAZXQMpq3jEJ2axEI8dFOAPCbcBKnmK6j
         /ZO+Iknhs6cnujPkJELBC6nC/odMJ0gQXq4m9zGG8dPAQT/A9DMD5oAcXwbvzjdGhmSQ
         BRMjaYDEuh/N7eC0xYZlDssRAsNMV5DA4IN1Q6D0kr1+Ug/PNtnwg3obm+1YGSudx7/e
         PHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778939; x=1793383739;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nKpQdPCfN7vtbw7obZJvLCHSgtoYzv6z5biXGbDum1g=;
        b=jihyjCEOPgJNcFxtjEYo4L6kWEUiS9Soc4c9/FsdYcUF7bgsfOcxE8jsQP1CDpxiFC
         S7jNPLI5o0EEqn0bbA3CPaly83x/AwEafmuCiP9uhz5ZHNXUJbyXpx3C4xhpukgL2KWu
         +FYFXZtVgf7ugc/ULiLjLFPjL1PtkNYbOWw9kc0DKxIzqEZP339ltKP0PZ3NsHYfi463
         4cn5IGgBGf4z/FmBoIHbSYy4PYtUxkQMwCL7YS4qDWqpwn6XxspWPrkbj9a721BiCK5M
         AjzVYu0mXmp+115mggZp92C/kYfN0SYKxtmtcU3ho4HhSw05M5sTTn5VVT1HFnGmt9/T
         5lDw==
X-Forwarded-Encrypted: i=1; AKwUvBwDEriVxGHiS4y80a3VFMVDOrgCafL/3yRt/uF8sm0M20Bv2bsYwM3LPq9VRbWsSHpGksDjZ4A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJlfL8Cil6H/X3Efy0/TfdQMeOLGjO/PGGrbFeDAwwcC0DaCyT
	aMfZNsBvheviZ5myn0slrli3S6tE/nKe2rxvTwrTCJC15FYc7s5cPLwIPmoLZ9V7oiZ47eh5Kpb
	Pu8aBBPaqtZUcPV1xlIwTZqOxXp18VOU=
X-Gm-Gg: AYBFou3dnrgXSUvgxwQhRGXDdgQeUOarExum83/9IakTlKAdnh/5ToFj3v6F6DP61sM
	TgpHAqT12tWSWvupP3P39wOkvthEeGIpGTQtEF5j23eaPoee5TeIA39rxretulE9NKNGlx75odo
	atJf1yy9hy80RBac1ib/fyu7p+EKkdi7/NKAh6K0apOyI0AUsm5a5skq5bT1vmwNvTgH3bvNPf1
	QDmHPZRCQk8GIT02/Fef96mgR26utsDtjv3aRGUOZShEf+zGgRJ0e6OTbVCTrYNLmHzueZvYYZ6
	UQAC0Vrspbt+6yC/BEzDbFRR95WLG+erqhUa05bFJ2zJ98KzXXl58O0YNayD2tbUuwt/nYgSYIe
	n6kWk1rRRgS3R/Ceam4MbM8qr5Fh70ZyAK2FLhDy7VFD14L88J7Hah5+OAEonjUtv1kTXQ9Q=
X-Received: by 2002:a05:651c:1b84:b0:3a6:62bb:906e with SMTP id
 38308e7fff4ca-3ac6fd4e4cdmr269461fa.20.1792778938495; Fri, 23 Oct 2026
 11:08:58 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAAzpgGfrHpQZQ8iaH5fqZHzk5tTx39+jGvGkVXxhYFkp-A_bQg@mail.gmail.com>
 <CAAzpgGeAaOjPdiVOmeY7xZqEymyh4BfhESwAvTzczvqj+YuNHw@mail.gmail.com>
In-Reply-To: <CAAzpgGeAaOjPdiVOmeY7xZqEymyh4BfhESwAvTzczvqj+YuNHw@mail.gmail.com>
From: =?UTF-8?B?TG/Dr2MgS0FTU0VM?= <loic.kassel@gmail.com>
Date: Fri, 23 Oct 2026 20:08:47 +0200
X-Gm-Features: AclHuK_kKsOTsWBx0Yucceg6CRaakmJTdlvJSrwgu8_JgodWjgo2txSWsrgvUvI
Message-ID: <CAAzpgGddO8H3EVb-WhXEeiCeoV97NuV0G22UZcHmyi0QZLwcMg@mail.gmail.com>
Subject: Re: [REGRESSION] mac80211_hwsim: CCMP frames dropped on fast-xmit
 (WARNING in ccmp_encrypt_skb, net/mac80211/wpa.c:462)
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>, Rohan Dutta <quic_drohan@quicinc.com>, 
	linux-wireless@vger.kernel.org, regressions@lists.linux.dev, 
	Felix Fietkau <nbd@nbd.name>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I tested commit 6832075ed4ef ("wifi: mac80211_hwsim: reserve headroom
for software encryption") for this report, and it fixes it.

I applied its one-line change to the v7.2.11 mac80211_hwsim (Fedora 44)
and loaded it as an out-of-tree module, then disabled my workaround
(fragmentation threshold) on the AP radio. Pinging the station from
behind the bridge:

  - without 6832075ed4ef: 100% packet loss, one WARNING at wpa.c:462
    per packet (10 pings, 10 WARNINGs)
  - with 6832075ed4ef: 0% packet loss, no WARNING

(The module also had my unrelated beacon timer fix applied, which does
not touch this code path.)

6832075ed4ef has no Fixes: tag, so as far as I can tell it will not be
picked up for stable. The problem was introduced in 7.1 by a536be923191
("wifi: mac80211: Fix AAD/Nonce computation for management frames with
MLO"), which made mac80211_hwsim encrypt CCMP/GCMP frames itself, so
7.1, 7.2 and 7.3 are affected. Could it be considered for stable ?

#regzbot fix: 6832075ed4ef

Thanks,
Lo=C3=AFc Kassel
