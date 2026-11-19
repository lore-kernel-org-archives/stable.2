Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070879;
	b=LkcmOuNSK/lGRqtxH43IVO++0CNjO0ic5/ThxkS/BMFWXXfjDRrkri8kkeJ1XxaJvdLL
	 zDYDnidTvGWH9OZduo2rs1kI9F1FBZdpJIYlDhfzBmsQiocBID2QOfYklEIPLlZOx8ClW
	 84noiwu+MvnlqZLYJ2uvLg32c3Tkekw7dGFUoscl580aA0mI0JupFTe9n3vVEUu0Hgnba
	 2JZ0Mp77kDxBjbiQ4TxEMVPLS6LJiBrQSgCPTX6W5twP+LirZxott+bh6vHekk8i0YTKJ
	 j/clkPoiwWHub9DEfMrMNOHrgjhKa+nqf8yCEkWQrUvXXk5mVD9WDqeaA8yjSCzX1Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070879;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LxBB4bfDBKtbdyNrDJ37xLMHzFUdGUh5uVwGq/0EjZg=;
	b=EMMgQahr1wlDkOB4ONW7Pk/BLmm8os746Y6UQXsidjBfFr+jFbXrX7SPDaeU7ytcPuAc
	 Ez3SHDv3zG5WnVILCMdq79RaUzy6oUrwv4UN2GDe+kyF2D/1Rr5Ip7zD/QK9EPbxzXf2F
	 VnVInKDvXKRXIwg01c7Avi9tYRT4jj/l544mpddyV3OvuVVPhsKyEW1/dsPNOQWbe88EV
	 YVaLOLlIx5Gk7rqfC4WJsRd89ZlZj1IzAhGWRE5SX8EbkRAe5FUloSSWOUpg+9+oYQTWb
	 euIw+rmMF/PIIVrgY0IKROF7iKgIH58PQZ+2yCys3PsPmYMf4ec8V4ZRQqz/aFaGZyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=CwG+wbro;
	arc=none smtp.remote-ip=79.135.106.31
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B60606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54B60606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=CwG+wbro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795070875; x=1795330075;
	bh=LxBB4bfDBKtbdyNrDJ37xLMHzFUdGUh5uVwGq/0EjZg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CwG+wbros33lBJmaxiJ1hOK85q/FYQUGC9wj0ZI5h53mQKh96taue4M0nK/mF6qNw
	 +ZmSxmjagUnltx5xR81gNG37T6Ds8vFZXQyvy5ZeyFGh/gxFgWfHMhbZLbJmKumrSr
	 FIg115G/8wUYxZQQPW+2bbSLrVbGINVQ/Dqiira8TQzvrY6BTzvsWo/iNsl1x64LkH
	 Vqi6BnB6Oc7KybmS3pjpQ6G8QF0IM0iHHoB9t1FZoH5XnA3EKLTG9Jg48yALpzfkoe
	 PHoAGegDOYWrA49jN4APdjKlZVqe3LgfhfIyECHOjnoUOx3hmU1YgfNFDbIJ2dQ9BE
	 EnMfsg70WaRtQ==
Date: Thu, 19 Nov 2026 06:47:51 +0000
To: stable@vger.kernel.org
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, Vinod Koul <vkoul@kernel.org>, linux-sound@vger.kernel.org
Subject: [STABLE REQUEST] soundwire: dmi-quirks: drop the ghost RT1320 on the Surface Pro 11 (Intel)
Message-ID: <20261119064745.65211-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 7d0a5f5483b03d7efb682bfb80648a3dfad95b73
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg, Sasha,

Please consider for 7.3.y and 6.18.y:

  d32e04c05234 ("soundwire: dmi-quirks: drop the ghost RT1320 on the Surfac=
e Pro 11 (Intel)")

It is in v7.4-rc1. Without it, the Surface Pro 11 (Intel, Lunar Lake)
has no sound card at all: its ACPI describes the one RT1320 twice, and
sof_sdw fails on a duplicate SmartMic DAI link name. It only adds a DMI
match keyed on this machine's SKU.

Tested on 7.3.6-rc1 with the patch on top: the card registers, one
RT1320 attaches, and a 1 kHz tone played through the speaker comes back
on the internal microphone. Without the patch 7.3.6-rc1 has no card.
It applies cleanly to 6.18.y, which has the Lunar Lake RT1320 support,
but I have not tested there. Owners of this machine on Fedora reported
the same failure and that the patch fixes it.

Thanks,
Sergey

