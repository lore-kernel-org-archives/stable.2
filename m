Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4330ACEE;
	Tue,  1 Sep 2026 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276095; cv=none; b=jDm6e/2kAlg/Rb8SdEAr3FPnSZtJeOFQmnVY/aMYAFZDt5r7naVINSzS2qpHDShhm9utETz6453l+IjnpY1eQZ8+Ux0bK9eJkfxQeaW7K4tuLRwDezjXT9aQSE3cargfiBXtkbhOq+U3l11k533vwK4t6N/AUr5DLtA+KFXKc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276095; c=relaxed/simple;
	bh=O2S372FAo3wlg76sfEUtNN/BTROfUMZrzULMv0o14Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA+cZOL/ZPsmLPht7dVbhJwIhiTI9hswBkZfX8xXXlQrh4x313aeyQR/yPzrPd45iwshGVUiuXXrHEwhrQPiYDkKvH+N1Liqid1W4DgqaYNbDUHIx6ZqYXC0b8wi4WS7OuGQILbxyLAXbBgFelMHiFcyjPAWOlDoHs6UBVT1hmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1y8V7Ko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1y8V7Ko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0441F000E9;
	Tue,  1 Sep 2026 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788276094;
	bh=oetRNe0boNm/WhtPpc7hRzMz+yRm89r+B4i1qUWFUgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K1y8V7Kox9aYdUasjLU+FkwFOrmrWnNrBP2kccpJB+735U4kIfhPz4CKrzSLwF06u
	 13PS/rkesv1jUcpbEUjFOxXaR3Yjh16pCQSE4njcWVE19SnLSGSJQbRV8eZgokhepE
	 7kCd/MLjJLBpx150JYkUDRJpZ/KCfUsdYK2EYCHVfujUYTpxUzDXWqqBLU1NC977Us
	 SBeMZwGO4TqfuVdSWN/Eoh8RZXGFQcI8CsbBuplMyRRuElEHVdIstTo0qafol3wGBz
	 9wu4JmsljkPQgAsynHbUe6UZPngpmY2usA5U9LgAMsW5sUv+ed0+PAQcAjJqmyddTS
	 QfS9OZ3hsH0vQ==
Date: Tue, 1 Sep 2026 16:21:29 +0100
From: Lee Jones <lee@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync
 entries on cancel
Message-ID: <20260901152129.GL2943942@google.com>
References: <20260901144805.3941205-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901144805.3941205-1-lee@kernel.org>

On Tue, 01 Sep 2026, Lee Jones wrote:

> From: Jones Lee <joneslee@google.com>

This is not correct.  Please disregard.  v2 to follow shortly.

-- 
Lee Jones
