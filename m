Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688383;
	b=ZSCUdcuNAfJl8cF44TsV6c/LrU1OaWAabkB9e5Ws1aVQ03dX26KyKPi0/Vw8d2CR+nwQ
	 X5sR5gGAzSnCus7bQnNF0+Gz/YWfnSN810Q919anUi/5eSlGwleGk1GIsSVix3SYVK7aT
	 2/5BrqQ+qwBYvhUKh9RHFN5a8NgBkLYi3MX58aOiho8nfw9qtThbsuKn8uaJA6qRo2izv
	 Y5Ubrx6gEjjsUzqCnVeaE/NrkAia+3wL0uzKRNxgeJt2Mb+Qficraufv+pnoolzQ9y7UM
	 lyvj/LHYtf6at/kq+qF0ubs2WbacjH8X25cedM5kTn0q/ICKgRoGAGOCQVb+hJ6SW/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688383;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7yiqVziuoi4MUfhVWRGe9sc8is8UXpPYgU3rcxw8mKU=;
	b=Dg48ZPNFHDQDOxatKMk2f3Dd3O8VwJCSbbaQC04REysWUCRsqWJZ57cQsNMWgvBn+1MX
	 iiuNJpUgAtoUL1SZcj9N7sTpfX2BEVQOr/3nD3y7PCdWaXW89uGiX2u27xsdna8cV3+KP
	 x8J1pS2REhXV/C1BMQTX1mVttErK05jYdrWyR07IUMg7Bsprf9hRIdlJle5lm8tH6oU2z
	 lUYjaS2K6S0vy1Q+YTebG4sreufOY/fEI8I9rX+l9O/J6jcIEcp797mReQVxOcR/pxFCo
	 +Mr1OaLob0VGDQSDWIVCvVP4B7pBoWxHSs1zVACIKR8iFwAC/lYyJsS6TUVEKJqQnrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bVU339Zw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B5606A31E;
	Thu, 26 Nov 2026 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bVU339Zw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7331F000CA;
	Thu, 26 Nov 2026 10:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795688382;
	bh=7yiqVziuoi4MUfhVWRGe9sc8is8UXpPYgU3rcxw8mKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bVU339ZwHLeIYWtY5sVcD1LAE2FstDOZkhQJjmHk+mpCwl/BkMu0SvUuyg1FC5BJF
	 +jdEcGOYrQm1DYnjYRKvXs73van3bMg9FNhLs3M43/e3h0fIct1TFQKHGrxqqiXUPr
	 0pw8uz6W2b7b3qGit/RvwCZWkKPZwCHAvZomLdbc=
Date: Thu, 26 Nov 2026 11:20:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yu Junzhe <junzheyu1@gmail.com>
Cc: stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 0/3] Bluetooth: hci_core: lookup hci_conn on the RX path
Message-ID: <2026112622-galley-skipping-e8a2@gregkh>
References: <20261118123533.25-1-junzheyu1@gmail.com>
 <20261119035758.45-1-junzheyu1@gmail.com>
 <2026-11-19-1-daily-reply-0012@kernel.org>
 <20261126075554.106-1-junzheyu1@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126075554.106-1-junzheyu1@gmail.com>

On Thu, Nov 26, 2026 at 07:55:51AM +0000, Yu Junzhe wrote:
> Sasha, this replaces the 6.6-only v2.
> 
> 79a2d4678ba9 ("Bluetooth: hci_core: lookup hci_conn on RX path on
> protocol side") is in v6.18 and is already in bluetooth.git. These
> diffs are for the stable trees that still lack it. They do not apply
> to bluetooth.git HEAD, so the BlueZ CI apply check will fail. Please
> review them for the stable branches.
> 
> 6.12.y already has l2cap_conn_hold_unless_zero() and
> iso_conn_hold_unless_zero(). 6.6.y and 6.1.y have the L2CAP helper
> only. sco_conn has no kref on any of the three, so SCO is unchanged.
> hci_conn_get() does not pin sco_conn.
> 
> Booted KASAN guests, same racer (patch-test/repro.c):
> 
> - 6.12.119 unpatched printed slab-use-after-free in l2cap_recv_acldata.
>   6.12.119 with patch 1/3 finished 371 connect/auth/disconnect rounds
>   and printed no KASAN report. The racer exercises ACL, not ISO.
> - 6.6.162 with patch 2/3 finished 123 rounds and printed no KASAN
>   report. That image is a build of this diff. The earlier #1 image
>   still contained the v1 SCO and ISO edits.
> - 6.1.193 with patch 3/3 booted and completed one connection with no
>   KASAN report. The racer then lost sync with the virtual controller
>   (unexpected command-complete length), so it did not repeat the
>   6.12 and 6.6 stress.
> 
> Yu Junzhe (3):
>   Bluetooth: hci_core: lookup hci_conn on the ACL and ISO RX paths
>   Bluetooth: hci_core: lookup hci_conn on the ACL RX path
>   Bluetooth: hci_core: lookup hci_conn on the ACL RX path

Why are these different subjects?

Also, don't send a patch series for different branches.  Please redo
this, one patch per branch, and keep the changelog and subjects
identical to upstream.

thanks,

greg k-h
