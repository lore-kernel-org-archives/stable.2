Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B24A4410
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295915; cv=none; b=lLO4PAoBsdFjUL6ZBaDpVYUqt4q3I2d2vq8EyYQ8FECZJ2b0tv5VNmzUQVtQrM4rULtVxwciweCHCSBJOZG5USssLGGWkp5E2dpNtWnJ9Y/yzjw4ixfe1THnAlyRS5tAdwQ7ZBj+mG6mQrmxbl/mJM4idV7IFqU6ixoon10agkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295915; c=relaxed/simple;
	bh=eXCRPqCg/v1CXZ9u9Jay/eYMzSD2wMDN659aNK7SdlE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dBa+00OWMv2NCwP2eGu3OivbIReKwVhmzGfML3i2fIA5HMbFGyPz4c/NKkyS1cPVlnLb6M5w84vGGGBNYkNai2RZij6zBv/TBhcG50T9Zfk03kJ+9q4xd1ljQSGK1hcBbTqAGIu6+3xd6ip6pWHq12cfW4TXSPPFui3WfgcG+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=mariushanl@web.de header.b=dWetl8PX; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=mariushanl@web.de header.b="dWetl8PX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1788295904; x=1788900704; i=mariushanl@web.de;
	bh=eXCRPqCg/v1CXZ9u9Jay/eYMzSD2wMDN659aNK7SdlE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dWetl8PXxokbzdmU1r6Xgs4OURNlCiqQJebSNmzhsBxk/W63wRPss+T+iKr4mdeW
	 /XlCNU0qdwyazF1q6iupiHX9og4ycWSGzu6QZlMxoFv5EJF9YpagXJGGPw/uhMxE4
	 eeTG37zWzCSg487B0a0m52z8tJy4gVclpEdPTBarrL1A4kHDtoQGN32gJI07XohJL
	 UN6N9+EmuMeCvi+Ou3BWyFuK0H9/DcswX5Fb4sOYUxhsAyIYaKJYJW6PXw88BbEmQ
	 QdOm44oQwFwpNO6+8/BbRL3/IPZhqc4YxziMWEyffuXY6j625S4W5EZKYRLftfR5A
	 wRb0IIfxsn1EDNoS/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKdLK-1xKGlQ25Hg-00XhPf for
 <stable@vger.kernel.org>; Tue, 01 Sep 2026 22:51:44 +0200
Message-ID: <6b456fd4-e66b-4b61-8d89-9fb50f078b08@web.de>
Date: Tue, 1 Sep 2026 22:51:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: stable@vger.kernel.org
From: Marius Hanl <mariushanl@web.de>
Subject: Stable request: Backport d5164580a994 to 7.2.y (amdgpu NULL deref)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UA7nkuP4dn9j7lZX/6eaMgFsknyp7gw8O3UD2eS1ZwRU9qGtBeM
 OY4Mi7QZnnXAJuKJI812JdpkkyNijIvPjcdZchhHOaCGTl8dORoVhCqE4iKXhNI+SYDqhZy
 w4uVPiMcdxaYRP721rVLq1KwhP13yNACOLjWiY8efAWmt5rYR3Ddem9RF1aqx73IsnUyW0A
 jdJyMmBNaqSJcR92CLXgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zMIZtNf+/Ww=;eYbv+Dd/5+TVPojXG3SQOM3cCRP
 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
 MfCf

Please consider the following commit for 7.2.y:

commit d5164580a994 "drm/amd/display: Skip Update HDCP Config In=20
Transition State"

It fixes a null deref I got today:

BUG: kernel NULL pointer dereference, address: 0000000000000000
 =C2=A0 Workqueue: events drm_fb_helper_damage_work
 =C2=A0 RIP: 0010:update_config+0x245/0x390 [amdgpu]
 =C2=A0 Call Trace:
 =C2=A0 =C2=A0update_psp_stream_config+0x23f/0x280 [amdgpu]
 =C2=A0 =C2=A0link_set_dpms_on+0x1a61/0x1b00 [amdgpu]
 =C2=A0 =C2=A0dce110_apply_ctx_to_hw+0x5ee/0x760 [amdgpu]
 =C2=A0 =C2=A0dc_commit_streams+0x487/0x650 [amdgpu]
 =C2=A0 =C2=A0amdgpu_dm_atomic_commit_tail+0xa13/0x4660 [amdgpu]
 =C2=A0 =C2=A0drm_atomic_commit+0xc3/0xf0
 =C2=A0 =C2=A0drm_fb_helper_damage_work+0x305/0x410
 =C2=A0 note: kworker/14:2[67932] exited with irqs disabled

I needed to restart the whole machine to recover.
Since it is a rather small patch, I thought I may ask if that is possible.

Thanks
Marius

