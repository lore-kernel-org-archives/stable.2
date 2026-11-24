Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.14.14.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532647;
	b=rvzoVxa6O2Qz3RwYWJ/pNmT55AvI4E1Dp43gPKnbt/NAfJoVamzpQBHhDnj121pA1YcC
	 7EBeyPtWx6Npt/6ad/eIoOngj/RnoHCCTo5hscqnaEpiiZTHQa6PndA6R/7llyv8uKXJB
	 kBr2ktVpNhv386b/sdrY9I1LSB/Jtsc9ANmtPjFF0LHGcT/s224ZKkCWIFQFL8VoUVUB6
	 vR1PypTgSgM/rDNfIywtkQ+9W/ojyNs/qJlqZUBelby1M+DmaW6Bfi23F8ib+vTsvEYYF
	 YhOagg5BcMHtv85WwptDjaZOsMm+F8TAC/ew3bas/7NPCL3j/oE5+rTop6Ka1CLwr5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532647;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=0HJPiESnZUwstyfi/RpQdC+U7Pi09ueYGo+obS0eNu8=;
	b=iNYsf6FDVAJM94aeeJBg97+C4K0fEy6cMSopv+v9PLHDYkOkMVe/8JebAjuEpJdhvyc+
	 /BZXwbvTxWGN8xne0cOgrRmBjJOivkSE2iBoIjZZIv0RdHfhZiNC2igejw7uPKe7J2TT/
	 +oBdqaBDf1LfqztiqLoc3vtopECrMC62UwSPgYlMLb0pUnnQwuiYEXgMCNIKLUZraXI42
	 7MSFKZvFi0rAlYaJ2QBUJ9GTPXYbkuPCCk2Sf6kA+v6gYWfDw77x476pJs5Gy7MdtXpAh
	 4EyaLBgCtW5iSZoF0Y58/xLaJIwcEnWLJ50rm0bEeP3/GQb3lP9HoMci6nem04gcSoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=taladin.ro;
	spf=pass smtp.mailfrom=taladin.ro;
	dkim=pass header.d=taladin.ro header.i=@taladin.ro header.a=rsa-sha256 header.s=default header.b=ACkygow1;
	arc=none smtp.remote-ip=31.14.14.46
Received: from taladin.ro (unknown [31.14.14.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99086606A31E;
	Tue, 24 Nov 2026 15:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99086606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.a=rsa-sha256 header.s=default header.b=ACkygow1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0HJPiESnZUwstyfi/RpQdC+U7Pi09ueYGo+obS0eNu8=; b=ACkygow1bnsylZJwWQtYGy7RQK
	U6jtyHQF8xLK9zBRpJTbAihBkjsEFe6knODGH8THjbhXo1ivhmWTzLFQPuO9NGKpkxE3vsA67Qywj
	VlLwVBUL2opwAQ5G8bR4m1jO447/soVxYFoB6tMTMEdoH/43NX12J37tmYyrvxGtJRvwt/j7oSA7w
	2AZQ6m4HxOKnmLUw75TuCpAb1izeD16d0jMYQ2a4LsO509mbWDIpop9htxfNkIq7WVVL9KdNWECGw
	2LIpU1Myd0/2dfr2KRfwxq1/2bX2mxGg4xqHW7V4pDVd/Aj1qQ+VrJ/T0Bzgn8aUGxP34+G9ph80s
	mIMfi3wg==;
Received: from [86.125.199.146] (port=58840 helo=mercury..)
	by cloud607.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <aardelean@taladin.ro>)
	id 1xVs3l-0000000BsAO-1UYO;
	Tue, 24 Nov 2026 17:03:56 +0200
From: Alexandru Ardelean <aardelean@taladin.ro>
To: linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
	hubert.wisniewski.25632@gmail.com,
	gregkh@linuxfoundation.org,
	b-liu@ti.com,
	Alexandru Ardelean <aardelean@taladin.ro>
Subject: [PATCH v2 0/2] usb: musb: gadget: fix lost Rx packet on first OUT request
Date: Tue, 24 Nov 2026 17:03:42 +0200
Message-ID: <20261124150344.69264-1-aardelean@taladin.ro>
X-Mailer: git-send-email 2.43.0
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
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud607.c-f.ro
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - taladin.ro
X-Get-Message-Sender-Via: cloud607.c-f.ro: authenticated_id: aardelean@taladin.ro
X-Authenticated-Sender: cloud607.c-f.ro: aardelean@taladin.ro
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Commit 3fc137386c46 ("usb: musb: Fix hardware lockup on first Rx
endpoint request") [1] made musb_ep_restart() flush the Rx FIFO instead
of calling rxstate(). A packet received before the first OUT request is
queued is then dropped. With the mass storage gadget that packet is the
first command (CBW): the host times out and resets the device, and the
drive never gets mounted. Seen on 6.12.57; version 6.1.119 (before the
stable backport) works.

Patch 1 reverts that commit. Patch 2 fixes the original lockup the
second way suggested in that commit: the MUSB IRQ is masked while the
request's complete() callback runs.

Changelog v1 -> v2:
- Split the single patch into a revert and a separate fix, as
  requested by Greg [3].
- Reworded both commit messages; no code changes. The combined diff
  is identical to v1.

v1: [2]

[1] https://lore.kernel.org/r/4ee1ead4525f78fb5909a8cbf99513ad0082ad21.camel@gmail.com
[2] https://lore.kernel.org/linux-usb/20261118115435.49748-1-aardelean@taladin.ro/
[3] https://lore.kernel.org/linux-usb/2026112008-dean-crabbing-a331@gregkh/

Alexandru Ardelean (2):
  Revert "usb: musb: Fix hardware lockup on first Rx endpoint request"
  usb: musb: gadget: mask the MUSB IRQ while complete() runs

 drivers/usb/musb/musb_gadget.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

-- 
2.43.0

