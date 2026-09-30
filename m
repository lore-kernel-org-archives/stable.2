Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A34D17A6
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770728; cv=none; b=vAkiZSrug2DZMoxOlalVcV3pNWhL2IJ/ae6RWfOOwNEIuEymXNW8aVbLCr+WM6gwTP2oZZ3cpYcfsoGvUEctcIJGcaan5XynMlpH5ZefvsSlOJwtWuoTjru6rC5diP+iJwzQMofd/2G6rPgE07UITgymU3eCy+5T2VRrhwzcbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770728; c=relaxed/simple;
	bh=i1g/m/McYmUzTbaFI6rMHEdVdrEWvtUuy1pK/NH/E+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teZG51Ky70wu5r15N1VE/oXc0dDcQKRq1Jxjv9M+8n9Pltp3G4CGaKXlvNKPMFI59tpSPOsmPC9WIAuKWOwJMc6+1I3wg0PRzYA1RO2IL/nG4S6GcOAcyuXHywSDWArP/35NGBO1hmIEdMJephiJpFLxLpEDnl0AZcXcfiNB0cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Y2x4mnV6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o4t+jNtD; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Y2x4mnV6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o4t+jNtD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92B597A00AF;
	Wed, 30 Sep 2026 08:18:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 08:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790770724; x=1790857124; bh=i1g/m/McYm
	UzTbaFI6rMHEdVdrEWvtUuy1pK/NH/E+0=; b=Y2x4mnV6fKLuiLl4axDtTsrlfe
	vg8ppp49TPlBE0+kqQvL5j81R96eYTDd4uldysNPX1+2YjBAFvMe5XOtKKTioOhY
	oweylF93MY0eTEQWWK81+NdwJnHCE+Py4z98nANXCCI1+7vEJMrG/vEzGo60JIp1
	Fq0OD08nUvTZsP3reeQbY9Xay7QwQqlt6BUmj6oAvzFwxhCRuIzvUVtYFK9XTe27
	OpdZfrKhQxRVwnvy+hpkqoVHVYwgOc+X3GPd4DqO4+4r5TuuYDB/Dx3Sy2a6x4q3
	D+2RrTQ9MvACcwKa3Hq/MX778D4od4ja9qmZMIR4UsOxOAWfmqzCq8T0gxXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790770724; x=1790857124; bh=i1g/m/McYmUzTbaFI6rMHEdVdrEWvtUuy1p
	K/NH/E+0=; b=o4t+jNtDfZEfrvxjeSPKpvVjsmnYBNno09bf0prdQo1HBBjbiEL
	dn2avHu7+BAkB6tROXABki388KMwvORRq6zZ964OM+eJpG6rm3sqz5YiC40UhVc+
	kyx3DAOjGzpnvxrWgayxeghkd12BKEXM3FCEaC5CSmay3ifiYXzbV/C7K7i5Kb98
	DXK+n4VFDBEcjaTiKkoGt0pl5R5pkwKe20cZ3hoVZr0jeJKE3PXMKbbjTPHya3ch
	+Djw3DNal5T7uA31gJOY5oA/ePcGaCB/f8N+jK4sBxR2IHvXY+tPGv7zUHmn8Tph
	IPG9hjhe+Wpt9JoF3t0clOc9wUUi+8q/E/w==
X-ME-Sender: <xms:I_68aoyjYV_ojSIoQOZkXizoRUzoyzGuDGbxWxUPQn4C9GACFDmj4Q>
    <xme:I_68aoI9d3lY4NcoB3jncMB_x5NLjDQq5RtAGvVNtWLcGwpio6PZP2Av4Ymugv3xJ
    LvIEK-yGQpmIAxm8IcqxU8fESbuSpFL1X4iyV44JrYW9lV1Ud4>
X-ME-Received: <xmr:I_68anUXqxhBeUabfUsBEIvj_tM0KxKH8OWWnObqAopyPUwfwkOJepeXiMuVuFED_14akMxdhF3ISrBWEDWECGKJsA4r1C9KaP-sSx2CGpk>
X-ME-Proxy-Cause: dmFkZTEdmy99Uvry3oPMcql56aR+Shh1hbgBbFM4gS03pF4ZaWd9JJd9fjF2YZBDQBZ6yY
    wBYgntszehGvUogzbbsFv5JOxRbScThB//a85UP66sGs1s8lc9QumBzIEaPt/Ks5nTPFmS
    K4qdZM/viKcOe9l3WAgPzc6pMKYeLWgk3pIlr7huwMvBFhLWRxBXAlykLIv16IRFdz4dFd
    wgdTziQjVrz6n7WMBtZF3ehMOx5XWx7aJbiSwQVo+oUFAQ5rV9YbtOLasky4R74RcEO5fe
    sTe9lNNGuYYydKRp5fdZxOgjVQ0Qnx1A9gUa+p0Kf/DbdZSeJuP8qm7kdCo921Bm0fW2ix
    6DtQ7WCF3mgjl897vrgkEHY51kYKbT2k5sO7BQRSpaBhpoJ49+CNh/AUIkP0OoNIrj2jTx
    7i9kh3gVVFSDowpteoJMDLyuy2OOSIhGyCf+0cc4oPj+hwdyKfBHta2ks6rYFqOWilsHcz
    laEZ3qkp4w7ie/thL2aI3o+ujQO9b+qD/pZlLmz3QXLRk1Y4R05cGHMyY7R+v8VcHFAXpG
    fdmC350qzshr9eLRIgsv34H8PqWYyJwc6iZOvjs11+joF7YHVRf+J75aa3Vq96lZGuVbWA
    AJGciypkKp7n1OJvzFy4iw31b6k7klh8WRSuyml5xAwskx9o5I0d44YDgmzw
X-ME-Proxy: <xmx:I_68araF-QqHVNi6Ufap9CX01K-iziSx3TWDTIkFNCn6IXjGg1MUyg>
    <xmx:I_68auyreLqZ7qzTqgL101ToRCNTzoUv_NCo-RDRhjv70luondADHQ>
    <xmx:I_68ar14FSguzt3Q8Y8hekWAOC2mGYoZ91ZHBFJoy4UVfj-EGH29Aw>
    <xmx:I_68avnMZNatMBAFfZUaCtLzoEUHRgiWaWzozTzzdtixYGEnitZi8g>
    <xmx:JP68amXy_rsB4CI-5Se3FIiixhMwIGk0fKPaRJKWNU8Wc8bLgp9u8QVq>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 08:18:43 -0400 (EDT)
Date: Wed, 30 Sep 2026 14:18:38 +0200
From: Greg KH <greg@kroah.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: stable@vger.kernel.org, Chunfeng Song <springbreeze@stu.pku.edu.cn>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.18.y 1/2] Revert "rust: net: phy: fix off-by-one bit
 positions in device status accessors"
Message-ID: <2026093023-washing-student-1d38@gregkh>
References: <20260928104855.205416-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928104855.205416-1-ojeda@kernel.org>

On Mon, Sep 28, 2026 at 12:48:54PM +0200, Miguel Ojeda wrote:
> This reverts commit 3267aea7cdd5d5c8851718b148cd25ff1a5374ac.

Odd, I don't see that commit id anywhere :(
