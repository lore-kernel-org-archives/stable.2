Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327E0395ADA
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727602; cv=none; b=dbT6dN31Bt5BCpTu/JEMMDRLzM35nFr+ES5krB1t7C71FoOXmMi0M/EsKH+Mdb/iDFbYti422lBivQ/0hGwTFFewc+7w7kgd4rYdvshwhwoPXlTG2E/yhHEzD8DTapr3Xlf+QG9UdMhd8pqkHZD5KQy0xuXuRLVWkw+mwvw5seo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727602; c=relaxed/simple;
	bh=LP+CjnPTNKJTOh9M44NP04G+M4Hbff+bxYnyBcwSMCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fg7mWtKQso93FXQ1MwupmlSUIm6m0IRnw3qKH2B9xYnuL13LtGPHi9IBRg6HYyRSrXWOeNxuYkaFIUdKwcr71ERtbDFE8K30SBTwHpRGaKV/BoqmkNA6euGCq3w/RD08ygjKmvgR6YVtF+KRJKduUe47RO+p0Dc5DpVraBIkbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rmdo7CJZ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmdo7CJZ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so967999a12.3
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787727599; x=1788332399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WauUjNIZUT9UpQVIgggxGeGxRKN9frgsdAp/zagOntA=;
        b=rmdo7CJZpHR25vsrePOxBFmoNzU9CeCqJIDRuYtMkL+HCbbpOE+ZsUHi9i86MZM2pV
         902Ie7moc1Qi4JP8zY3ACU7Z14NVnW7qHwI7a2v3MoMfS2DFrgW7gajNdztzt4rO2l4l
         f+exzOtVBYf8w0KY8SFMSLP8s6uGMCesWbgEsNUyuDIpBxpzWwFLe5qPyv7OONltBxiN
         JG3tzXj53hz06CMzpcu3U17Amc3mK1q0fPPBOffBRp301L8uEr56NUa3/SoOwOU2iTn6
         L3SgmVdMbraliotZjwKoiUdSkgBvcdfeE+GABeeSeR/yVVV3yQBx5HGtoaxtf2WELIhU
         uYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787727599; x=1788332399;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WauUjNIZUT9UpQVIgggxGeGxRKN9frgsdAp/zagOntA=;
        b=pfKnniCVLJk2W3ql5LYPnMub5+S0hhn40LCvWfLISfaVMgZ3sG8d5gnRBcLGQQrO6w
         1E536tdfV14Frg9oBGi+zc3YuyRjKdwV2KBjSKyV7U1Jtbu2rIp9ieAXrGnAnxkdsaNs
         bSlhdqd6iTEYYdTrXjG2S32vDiwhjrxXFDWHCNhXFEpl02omiKPweIBh0mtF9yFFAAkv
         RBg9LS798px5SBwB4u+brf4ucLYNcgcsyLRmRzWY5p2olnaPIs5WiGS+AGa2qClIo+gk
         5sQ1NlGhCnTTe+/J4XsTBwuNMekJ9QSrRuB3aIfR/F1UcWt11fmvA4BvQ834JQt6veh2
         h5BA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8D5z3sn+ODGG3pC6IzaQ08CHpeP6Yliq+WoxqF7Zgs6qaDvEm+lxASPGCrUV+sb/Iy/CVrvo=@vger.kernel.org
X-Gm-Message-State: AFuF++l6woGtzSUwISX3g8PWW7+suSR261WQpk0aq7brnm8oxBklpKUT
	1/55xl5usCNWx4HT2YM/e7TeJ7xgFZxJmEPtB47NhSO+jhHEgPq1wyk6
X-Gm-Gg: AR+sD13qlWuyz5E+jEAVnc/1WbXdih+6yF1/fDOmem5p3DsmO0KwCWUEYE5vt0ykxsa
	OyZKkdK3yKOgwqP4+sSGBQVKdD7yhQ5saN40KBlIMngnK7F5Xh75/xNvbHu8/pJ0jMnktSP12cr
	KJjD8g+OhU+v0J5HBW/8Gkli2JVd3edxCDRWu51DfiR7xmRUYnlKR7+Q88I354FzDVQoj4QElMp
	EVMbFtaD9QmGuj9mV4bECp+dqV+MUzmPB7QeEQRqym7PxgZx/G9KC3kiaPYKQXr4qv+E5YwvTmA
	D6YsK4hW6dgRizpU8cuXiUxAaMmwc58x/nQiMOzQVhighVp9xPARrrHJz5bWIBCcyBzr+nu74vF
	+CWvWIHi3mEo4ie3bfJoobEoD0dUjufBwFsHt62SOFIv1YGT3JzrEnolUjbF4f/4Sx9LKhwztTD
	eLq+ZcEny5yKZbGSsefRp8raUbFv0qje2NTaDfG/CMOA5LVJnuJGIme1ysMWSIk4dCIy8n
X-Received: by 2002:a05:6402:1f01:b0:6a1:b0b:bc2 with SMTP id 4fb4d7f45d1cf-6a5df65b8c9mr6399127a12.10.1787727599087;
        Tue, 25 Aug 2026 23:59:59 -0700 (PDT)
Received: from foxbook (bfk5.neoplus.adsl.tpnet.pl. [83.28.48.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8d0b71sm2826662a12.9.2026.08.25.23.59.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Aug 2026 23:59:57 -0700 (PDT)
Date: Wed, 26 Aug 2026 08:59:53 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mathieu Fluhr <mathieu.fluhr@gmail.com>, Lovekesh Solanki
 <lovekeshsolanki00@gmail.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Mathias Nyman <mathias.nyman@linux.intel.com>,
 linux-usb@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, Forest
 <forestix@gaga.casa>, Slavik Dev <developer.slavik@gmail.com>
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
Message-ID: <20260826085953.7f8e3949.michal.pecio@gmail.com>
In-Reply-To: <f6f2f984-f31b-42c9-b120-6c179803dd2b@amd.com>
References: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
	<CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
	<CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
	<07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info>
	<aosGtkE_diwVJJtB@eggarch>
	<20260823174059.46fec036.michal.pecio@gmail.com>
	<aoser8dLytrwqBC2@eggarch>
	<CAPyJwA8m_Xd2oyV1i9k+-6f7A-j0FiC97yXL=Ci8ZAErs5W4vA@mail.gmail.com>
	<226b2f34-fa25-4ca6-8afb-0b3dc942715c@amd.com>
	<CAPyJwA9GvqeaBYhN56L1S9YW-rwWgFejrcNcE=54DQC3Eaqxww@mail.gmail.com>
	<f6f2f984-f31b-42c9-b120-6c179803dd2b@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 22:14:32 -0500, Mario Limonciello wrote:
> This isn't a BIOS regression, it's been around since the beginning on 
> this threadripper model but it was harder to trigger.
> The Linux kernel changes in the bisect exposed a platform issue.
> 
> The workaround you can do for now is to disable runtime PM on the
> XHCI controller to avoid triggering it.  But it's a platform issue.
> 
> For a proper fix you need to reach out to ASUS to get an AGESA
> upgrade. You can ask them to reach out to AMD if they need
> assistance/guidance on the versions that contain the fix for this.
> You can share this thread with them for reference.

This sounds like it's a known FW bug, so I suppose the exact failure
mechanism is known too. Is it triggered just by putting that PCI
function into D3 at a "wrong" time, or is there any USB/xHCI layer
involvement, particularly anything out of spec by software?

I ask because we know one case where dodgy SW actions cause some AMD
xHCI to malfunction, but the problem is contained in the USB layer and
the affected xHC doesn't bring down the whole SoC.

Any thoughts about the patch which reduces suspend delay for root hubs
specifically? It restores the original timing of PCI resume/suspend
cycles, at least as long as there are no external hubs connected, and
has just been reported to mitigate this problem.

Regards,
Michal
