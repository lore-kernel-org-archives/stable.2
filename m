Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA519D065;
	Thu, 16 Jul 2026 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784182607; cv=none; b=GDk4UdgO99oMQ+ibIy9JRKMXabR4PvhX8i2VE/nL/6m3UHXwEeQmi+rgT9oWNhxNfm7hP0VpV/eEty0K0oi7X/OUTmpLCzhhNnL5VgXnB49nlrjlrjEADim+SpSuBl2oB9z7RorTO2s+8W4+Z05zM+QtvNogXIMdkEij1g1RSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784182607; c=relaxed/simple;
	bh=addmv88j0Xu4JUyvR2dcrA8FcqtCst52bo+WY6OwlrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFtDhmZW0nWnvNkcWCGX0Xl3ZOBzEawZnC3ic3fD/wnh3wyCawYiDurWHzX5t8dtungWidDuJkXhY0XUPBzfUt9OzNpTUijgNSYnZ1AK+VOtjLhcHlmPw2+VMRuR4CHmbyPUcKVIWL+Q0LER/Y5wGt19VOouuy7PVjGUkeg4i7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=KoCF9EwJ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="KoCF9EwJ"
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 497FF1FDF5;
	Thu, 16 Jul 2026 08:16:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784182599;
	bh=n6iSatnfcLyfSK3xu5jb2NBn/vj4lKDd2SjG6/+sQhg=; h=From:To:Subject;
	b=KoCF9EwJZPxaacEOzgbG+HCsPEUkHkBDvrR9TQcJbYjWASLUYOEkzxKDR5zkq9a0k
	 ZtAxK3rsQsZovdXT7qaoZpiQzcaP6KebtPX/lLfcc0feBQu8g5oafp2Xo7DN7NPWJe
	 t8o1L96GFEhVE3L9jIo6k79yIjYGCTtquRA8E5Hm0rQQaBRCAlGm97TI+eckQBEetm
	 +EyDvCx4ppQcv+/y/Pu0HrbzYhRWXO4YU9sR8MwXMLWpv0w65ZwZSHK8fDGsg1vr+Y
	 vclDUlCtHGQmzYbEax9BvIZxfwhl4PG01UHrzoXHEFad2MiLY8aviNtBZ4zLryMrIW
	 Tjv4z/RK6TysQ==
Date: Thu, 16 Jul 2026 08:16:38 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Georgi Valkov <gvalkov@gmail.com>
Cc: briannorris@chromium.org, kees@kernel.org, francesco@dolcini.it,
	johannes.berg@intel.com, bhelgaas@google.com, error27@gmail.com,
	s.kerkmann@pengutronix.de, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: replace one-element arrays with
 flexible array members
Message-ID: <20260716061638.GB9973@francesco-nb>
References: <202607150932.F2A0836@keescook>
 <20260716001728.57799-1-gvalkov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716001728.57799-1-gvalkov@gmail.com>

On Thu, Jul 16, 2026 at 03:17:28AM +0300, Georgi Valkov wrote:
> Replace deprecated one-element arrays with flexible array members.
> CONFIG_FORTIFY_SOURCE reports the following warning when
> one-element arrays are used as variable-length buffers:
> 
> sta_cmd.c:1033 mwifiex_sta_prepare_cmd
> memcpy: detected field-spanning write (size 84) of single field
> "domain->triplet" at .../marvell/mwifiex/sta_cmd.c:1033 (size 3)
> 
> Convert affected structs to use flexible array members.
> - Preserve existing wire layouts.
> - Use DECLARE_FLEX_ARRAY() for structs inside affected unions.
> 
> Tested-on: WRT3200ACM, OpenWrt
> Signed-off-by: Georgi Valkov <gvalkov@gmail.com>

Cc: stable@vger.kernel.org # 6.12+
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

