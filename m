Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849880;
	b=mCN4KY/BqAeQHeG9DyENsHd/QgHbnuiMeNTxB+TyqqmYGHtptJTQAwX2Uy6DJLyB1N+x
	 ym9iuTgOb5j+gnvHilYqie3UZwz49cKmKpTY0OPDaexxSsVtbgOqYSZAaFI4BvVjprfaK
	 8P9zSPVt/k5tjl6PIzSveXIgcQM/sCKuMKj3oV2VR+iurJZY6bEPiPER8/QeuXs4BXAVO
	 FVI96ua8JE+BvQMWky9by3YRGqxDONcTlYNu1l6Q0qWuia3ZhqRRIpfVr1XILmr2Y1O05
	 AHBhqzNbmlpz45wlGs32Ln7+5R1phCdxd7Pm7KthHpmKsnXSCBO/j3Z0829azlUFPNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849880;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wKQl+YigGDBDremvuG6tzQKQ4x5z4Gx5JaxzCuaqXF4=;
	b=p8xbyAPs+o/S7x8eHiClmlcecMp0tAFnqSmmFMaRa0DQIH5J/7fgrqwigLDUvN7RXhW+
	 g/MYGvZKy6BS7WI+sMEh+/cN4fFd+bLJxf6FCHZdd2lmicQhulksCXDhym/bbT8wPV5Jy
	 XlmcHnhaCf1sK+wgRphOeAYCIJCtjaiK3xLdb6Ew/m91XCSFLyB66nYjnT2qt7kF2fv1f
	 XvlDWehm4/aaaE0AREOhPZPGejxmjkxWcEG8B0BbgmC9iLnsLT3Zo4vSdYe8ohyagHyx9
	 5U0JKGnhg+JhEWKF+GbVdNW2JRPAigfBSfCo0/gZkM3LX64y1do8ovFXR3wnPcxHfdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MXXMR/5e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88441606A31C;
	Mon, 16 Nov 2026 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXXMR/5e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FC41F000CA;
	Mon, 16 Nov 2026 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849880;
	bh=wKQl+YigGDBDremvuG6tzQKQ4x5z4Gx5JaxzCuaqXF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MXXMR/5eSUhzFqIsmILdpZpp67LQl+0b3nk7gWOHu7vKzhWScTZ1iJwnHN2akub6a
	 JvghUsEihIJCO9vx0uaDUH/Pnpn42tuxYA0IMFkMBt0ZpiW3oO8xIGDlMCJ0W0TjsR
	 sL6saXhL3qp26TEUMSWYwxzc06nyXP1UH8rI6NVNsqQoVP20hbMdvODPboqGQcwKqH
	 7WtG8n+h5zhQHrxdVPJw7sPjDhmjOu5t/65r0DvhFyyWv8OmtRIaEhuD+SMY3tvvMn
	 7DWGfcixyEJeUAsTH9ugO0lG3sg9Uy4pPigO33kMRKhFsSJxbgq+z6qLqXk43J1fJQ
	 1SQJEKXSuQJpA==
Date: Mon, 16 Nov 2026 18:24:36 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: shao.mingyin@zte.com.cn, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/4] ata: libata-scsi: reject reserved bits in 32-byte
 passthru
Message-ID: <avs8VMjIphKkvc9S@ryzen>
References: <20261114014801031Y999WJfhmUrM7FRlZ-2Qf@zte.com.cn>
 <40839783-b23d-41df-8c71-19fdcca00323@kernel.org>
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
In-Reply-To: <40839783-b23d-41df-8c71-19fdcca00323@kernel.org>

Hello Damien,

On Sun, Nov 15, 2026 at 11:01:10AM +0900, Damien Le Moal wrote:
> On 11/14/26 02:48, shao.mingyin@zte.com.cn wrote:
> > From: Shao Mingyin <shao.mingyin@zte.com.cn>
> > 
> > ATA PASS-THROUGH(32) has no MULTIPLE_COUNT field. Byte 1 is CONTROL,
> > including vendor-specific bits 7:6, but libata interprets bits 7:5 as
> > MULTIPLE_COUNT. This rejects non-multiple commands with those bits set
> > and can print spurious count mismatch warnings for multiple commands.
> > The reserved bits 7:5 of byte 10 are not checked.
> > 
> > Reject nonzero reserved bits in byte 10 with field pointer 10. Skip
> > the MULTIPLE_COUNT checks for the 32-byte form while retaining the
> > device multiple-mode check for READ/WRITE MULTIPLE commands. Also point
> > to byte 10 for invalid PROTOCOL. Keep the 12- and 16-byte count checks
> > unchanged.
> > 
> > Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
> > Suggested-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> Reviewed-by: Damien Le Moal <dlemoal@wdc.com>

I replaced this with your @kernel.org email.


Kind regards,
Niklas
