Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779530;
	b=v66yMk4QFA3aURPnRJ3SeSmU7MFh54flzpjqWLLIBECTYCC6pOC9SGbRKti2mZGb1ybl
	 I3SHtk15VWJcfsZdIsJMZUYOEJvT1GE8X3x1ROxeqZOzNigEZbq5vSoc/VpHsRQ6gzlVv
	 RLZ9h06WPSfYr3J6iKbxLoU/gU6R8U2q3y1Jij7zZoVD/HneGI3hzl6qZqukEIvsA+koB
	 tN+C0g1ZdnN9WahX1KttOgj8AU0hP6q++S9eQyamo82FDFe2BvCc+M+gEQ7CqH45GQtU1
	 Gx/dbdxpXMzJvRP8e3JFjI4iGjXhSB4IgJ1ZhopfoS9Ly164jjXZnDopzOA9mm/kPuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779530;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=6GRLSB0LkFDh3Az2ScuINldyMH7GHPJZtPzhv3mBq9g=;
	b=5kOKc57xDOSHrNhkWVTqeRUHApwfns5DamK9SNovLg33vZ7aLqyh08t5LhqlAYu9u8aJ
	 tcc/OGSsJGCFIPD1d6b0BF9gZDN1a1ISMvdMLijFs/IwbKitTbkcJpm6SThAgzE4ZD0vD
	 u1fSu/IqV9VnnlOBgaOxhS5bkdw8Hi1zAn/EOhCV+fKOZBWMwtqg/hZlWyL+z2ZPJVAAC
	 jKAnN5evnwNMPbpZdksgTJUxAKxjj9AMI+6WEaUSW7SgjulZMj+Xz0BBzghxCH2tVmmwE
	 U0V9iI6tss/7I8M8u8JSUrUvfqkV8jXLfhBo9orH5yNirpyqZLdEy5gsPGfXUM4UFVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EN6sq60q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F2606A31C;
	Fri, 27 Nov 2026 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EN6sq60q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568381F000C1;
	Fri, 27 Nov 2026 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795779530;
	bh=6GRLSB0LkFDh3Az2ScuINldyMH7GHPJZtPzhv3mBq9g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EN6sq60qKpx6cdKF+R79n+z5qwzaTKzvrcMvZzx+FKU6GBn2eC8+hm67fVNei3TQO
	 +ttGoxmqoregBZkwucAJ6Ey8WDnLmpLANL76xyY0a7v1bQfrsy3xvk/joA8eB0Ed0C
	 gIErMq/LjNOwX/1LRI1yKjn6O4Sr+TDieO7KNT7/mmws4jIebbYPAYAGY93AOMXQBF
	 IL7XMKJA47EtW11xsn+5VEor490XF+HwRykPTjra/RQ8SGJnD8n1S1PU0cUsqa2TCz
	 EtJmJhGwe8+jwKmZT6muAR6KvnGXRKQWU36E557J5sYLcPGIw52i6TU2jGQbHsoSZV
	 Cb7dE6bXAVsLg==
From: Srinivas Kandagatla <srini@kernel.org>
To: Stefan Ghetu <stefan.ghetu@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Christian Eggers <ceggers@arri.de>, 
 stable@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261125123222.839732-1-stefan.ghetu@nxp.com>
References: <20261125072736.769516-1-stefan.ghetu@nxp.com>
 <20261125123222.839732-1-stefan.ghetu@nxp.com>
Subject: Re: [PATCH v2] nvmem: imx-ocotp-scu: assign
 nvmem_cell_info::raw_len
Message-Id: <179577952810.26171.4681620361153963106.b4-ty@kernel.org>
Date: Fri, 27 Nov 2026 11:38:48 +0000
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
X-Mailer: b4 0.14.3


On Wed, 25 Nov 2026 14:32:22 +0200, Stefan Ghetu wrote:
> Avoid getting error messages at startup like the following on i.MX8QXP,
> i.MX8QM and i.MX8DXL, printed once for each MAC address cell:
> 
> nvmem imx-scu-ocotp0: cell mac raw len 6 unaligned to nvmem word size 4
> 
> The same was already done for imx-ocotp and imx-ocotp-ele by commit
> 48b5163c9575 ("nvmem: imx: assign nvmem_cell_info::raw_len"), but the
> SCU based driver was not covered.
> 
> [...]

Applied, thanks!

[1/1] nvmem: imx-ocotp-scu: assign nvmem_cell_info::raw_len
      commit: 710ea17029b60738ffe6c93e6da3ef6970727d0a

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

