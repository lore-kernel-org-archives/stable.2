Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795630144;
	b=H0EQqf162gyNaO0q7wd1+lSrJp4Rrxu74Xo4PCfVRC/0yYajwA6uUb4SZYKAegADEHGh
	 DFVEiskvtJMdlys3jmjNLRt8s5nNASKMUkRlC63NS2CjLBI+2DmNv/x8V3Prif/l79yTX
	 vrJmGBwv9k41qkJSFwdyF6EyFun+0zzZ87QoBjQ8eDsg4j4S/toqprIRUbCEixKiimWW9
	 E8+NFZE2zk1jhSIWZ2apQNFlwoxpcymNTsuvm+IoXlchPu04d/byGbyKzc/cGLILaNdh9
	 ZPvJuPtfTRjlThd29XuOQ9eguOFvRJ9iVBRXWQbpSvULgmtjC8PIgeUs/kYFfxPGlUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630144;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=W3UTAwZ6fmN3bnxYi+Rd1BmsmeXOgoLChUG1cnYvgGA=;
	b=QxLCQtMUqFra9CWG38vYc4W+CWxZuzlASvJmk50QpeKuA9NKNEnrF4TPUSAzSb5rkmZ1
	 kPC0jxhvO0OmB1qCSxOm78+iLjb09c4wrr0ma+tifqdAC6dSUTronBVhx+2ElIinx7Rjp
	 /zK5RDrZ5sZd41UX9HHtTw1or9z8BRHcmSca/3OeONWv7A84LDjmJl3P8217gAUKVKW29
	 f9xgl1ewDYJzOI0S8qYJLXXI53jrmEVDhR81NqtrYnEVoRQkA9oefJIpzwri7g178QvtR
	 LDgWbdEXmeN2vt1h90z5WenfxvH6OPALDhmPDXYwavep7+RSwahRD2Q6XUD7kHgzWSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=ixiWA+ex;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
Received: from sender6-pp-f112.zoho.com (sender6-pp-f112.zoho.com [165.173.180.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77EC606A330;
	Wed, 25 Nov 2026 18:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A77EC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=ixiWA+ex
ARC-Seal: i=1; a=rsa-sha256; t=1795630125; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QAm6XZwVIMUr2wf73DxmKG4hZYjwyqbuvJHpdAbx6DjFhuL2+turqtHpWlwvoGTgQ27lv2ensfJ581cHlmXvvPoRaaV6XssabZihKcn3YI93FZRYHr0uYrIzH3ym6gqu0G3h8spspLqPqCkaUbBiQ0gnCVxbb/1ZJynOCCVmzTc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795630125; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W3UTAwZ6fmN3bnxYi+Rd1BmsmeXOgoLChUG1cnYvgGA=; 
	b=kb2OEXrk7SBL8RCqpqVGyNYbeAKZzKzc3BkzNfPCfmLWB1NIhXP5XAHWO/erajYVEbZiNSTFyUZ2CFIiwmVnQ1NUwRLixJF0E5zw44uaau44Nd5+p5vkd12qqHcsuCanhmXOl7HvvWAwWZ54nemIGidf8FY2pNxDtfuxHG7/8xs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=ixiWA+exoOBd7eMuVqO9ABcuZEk+/hqcg1TYEekNFrUWsw4RfBer3hYpiIZabjReNK6uAdMA2opD4onTWeGgv+hm8g52qmPcd2RxFsd9mi0msqJRFjV0z/gs+MqRQxU6rdWMQ4xTXRx2jNsZed19zu7Yx4grLJHfA+nXaXte0MsHFDDnUtq8zLbe8760CbFMgrSg95V68qg72DcQ4OBEG19goUuC3cWZAWKtFGVJceaYuBmw6pj6HQTLWbmWQaExqqZnAiam7u6qJcTE3q2zPLm+dAjnryfdpYPXoaNEvsCymty/9Ns951Z1SeMltd/atwvjlSncxRPN8YXISQ1hhg==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=W3UTAwZ6fmN3bnxYi+Rd1BmsmeXOgoLChUG1cnYvgGA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795630121080693.7539799516549;
	Wed, 25 Nov 2026 10:08:41 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH v3 0/8] platform/x86: ideapad-laptop: Trigger the EC on YMC
 events following Windows behavior
Date: Thu, 26 Nov 2026 02:08:18 +0800
Message-Id: <20261126-ymc-82yl-v3-0-e30842671ec3@rong.moe>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NQQ6DIBQFr2JYl4aPSLCr3qPpAvCjNK02YEmN8
 e4Vu2E5yZt5K4kYPEZyqVYSMPnop3GH+lQRO+ixR+q7nYmQGpRmki4vSxVfnrRrWiOccqoFJPv
 8HdD575G63f8cP+aBds5+Xgw+zlNYjq8EeUc44xIAimwCyqjTFjQ3DLQS1zCN/fk1IcnVxAuPN
 4XHd09yYTpratswLLxt234D+1ZF6QAAAA==
X-Change-ID: 46a18a06-ymc-82yl-d59b4f8f891e
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Gergo Koteles <soyer@irl.hu>, Ike Panhc <ikepanhc@gmail.com>, 
 Andrew Kallmeyer <kallmeyeras@gmail.com>
Cc: Eduard Aliman <edialiman20@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mahir Faisal <mahirfaisalantiq33@gmail.com>, Rong Zhang <i@rong.moe>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

Currently, the ideapad-laptop driver triggers the EC with YMC command
0x01, which is necessary for existing devices in the DMI quirk table to
clear the pending event to allow further events to be emitted.

Newer models do not require command 0x01 anymore (writing it is a
no-op), but some of them require other commands to properly synchronize
and set the hardware state.

It turned out that Lenovo's YMC driver for Windows (YMC.exe) writes YMC
command 0x08/0x09 on fold/unfold YMC events, in which "unfold" means
laptop mode and "fold" means other modes.

Adopt the said sequence and combine it with command 0x01 to make
ymc_ec_trigger work on all relevant devices. For the sake of caution,
write command 0x08 only for the known fold postures. For all other
postures (including unknown ones), write 0x09 to make sure the touchpad
and keyboard are still functional. Finally, 0x01 is always written to
ensure the pending event is cleared.

Beforehand, also fix pre-existing issues, modernize relevant WMI
drivers, and add a resume callback refreshing the posture and poke
ideapad-laptop to trigger the EC. See each patch for details.

With these changes, add DMI quirk table entries for the Lenovo Yoga 7
14IRL8 and 14ARP8 as their EC must be triggered by software on YMC
events with command 0x08/0x09, or else the enable states of touchpad,
keyboard, and keyboard backlight become out of sync.

Reported-by: Mahir Faisal <mahirfaisalantiq33@gmail.com>
Closes: https://msgid.link/CAGAHqH6o0TUa1HXMrNV6e+HNYwU3xxHkOM665756n8Cp3AzhVQ@mail.gmail.com
Reported-by: Eduard Aliman <edialiman20@gmail.com>
Closes: https://msgid.link/CAA4HgYKab7_GMCNdHF9+E=9ECVBHRs_axefeCOnZbUNUoyVSoQ@mail.gmail.co
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v3:
- Always write YMC command 0x01 at last (thanks Gergo Koteles)
- New patch to address Eduard Aliman's report
- Drop Eduard Aliman's Tested-by: since PATCH 6, please test again
- Link to v2: https://patch.msgid.link/20261125-ymc-82yl-v2-0-624bdcb3c50e@rong.moe

Changes in v2:
- Rephrase the commit message of PATCH 6 (thanks Mark Pearson)
- Fix typos (ditto)
- Link to v1: https://patch.msgid.link/20261116-ymc-82yl-v1-0-fac1a2b01a84@rong.moe

---
Rong Zhang (8):
      platform/x86: lenovo-ymc: Use enumeration to represent device posture
      platform/x86: lenovo-ymc: Serialize WMI event handling
      platform/x86: lenovo-wmi-events: Modernize WMI event handling
      platform/x86: lenovo-ymc: Modernize WMI driver and factor out events
      platform/x86: lenovo-ymc: Refresh posture on resume
      platform/x86: ideapad-laptop: Trigger the EC on YMC events following Windows behavior
      platform/x86: ideapad-laptop: Enable ymc_ec_trigger for Lenovo Yoga 7 14IRL8
      platform/x86: ideapad-laptop: Enable ymc_ec_trigger for Lenovo Yoga 7 14ARP8

 drivers/platform/x86/lenovo/Kconfig          |   2 +
 drivers/platform/x86/lenovo/ideapad-laptop.c |  74 +++++++++++++++--
 drivers/platform/x86/lenovo/ideapad-laptop.h |   9 ++
 drivers/platform/x86/lenovo/wmi-events.c     |  38 +++++----
 drivers/platform/x86/lenovo/wmi-events.h     |   1 +
 drivers/platform/x86/lenovo/ymc.c            | 118 +++++++++++++++++----------
 6 files changed, 175 insertions(+), 67 deletions(-)
---
base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
change-id: 46a18a06-ymc-82yl-d59b4f8f891e

Thanks,
Rong

