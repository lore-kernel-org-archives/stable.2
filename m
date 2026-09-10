Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F431F9B4;
	Thu, 10 Sep 2026 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061289; cv=none; b=cLya53TTSXPYSuNKtlQmYL+BM5AQkkczHVSzXzeWtcfn/13w8ZfI+lU1JUWWViR/Xcfd3MPgaR1gyDUslDj/G4hros9Zvg1A1pYxXywclXdz+FVPfcL1JFCxzVIhDpUT+59ObhI8x7XALs0uP1NK4O3PzsUccZFm7U3X3Z6w3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061289; c=relaxed/simple;
	bh=uV6SREfYxwnRV6VTsQsVUrjgaxbJcayGe7TFE7OTWRU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Uf6bYk6n9cRES8WZMLuCuRV6SLsGIkYpu2Zr27RiAtJ52D0ok/AX9V8LUsvYvWcWnQQv2QFyexgMKXcIhUSTrcI4XeLTaOm7TyynBUTJdKS6TkeZ+12mluUO5/lF3oTVvdigqmuNkuySgOknNMLvtvDe3GwUrU/yWNxwD7vn+jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRyv4fxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRyv4fxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593E51F000FF;
	Thu, 10 Sep 2026 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789061276;
	bh=YF90JZ4R1naeQs33hoFLocHF/2/HtbpKIpsBUbwYfKI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bRyv4fxN3hvz370EyxcaLcTe0HCQTP25kU/ID0dBIRbnbLmqjSvSMwKMO6T2nSmRB
	 wF3rCm/FfQWRgdxUkrtmy/dIqQKDOB8w6bnVTtVEMvvKhwdBJ+VVVBAJ11Vrf8xTXp
	 gY2WT6utJNEA83RqQ6uKe0COY9XGIUjwMuzTEHrki/uy1ctyOrGz/th9jyzEfSvDbL
	 C+WHfRWaCY/vDWeJ0/J+Mlw11nw7sVUnLGwOpKlrEyfmc6InuYs/Mh8EljqHyhG7Gu
	 8fMKynPZvJVf0pTPFFykk0TyfErNLcN2JAxAMkoM21gkYGdMTCWH/LBW4jFpx7nOT+
	 ZtIXeQ/4gy9ng==
From: Niklas Cassel <cassel@kernel.org>
To: linux-doc@vger.kernel.org, Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260607064053.195166-1-enelsonmoore@gmail.com>
References: <20260607064053.195166-1-enelsonmoore@gmail.com>
Subject: Re: [PATCH] ata: pata_legacy: remove documentation for removed
 module parameters
Message-Id: <178906127506.133610.11169524581202806482.b4-ty@kernel.org>
Date: Thu, 10 Sep 2026 19:27:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Sat, 06 Jun 2026 23:40:49 -0700, Ethan Nelson-Moore wrote:
> Commit 3c4d783f6922 ("ata: pata_legacy: remove VLB support") removed
> several module parameters from the pata_legacy driver, but neglected to
> remove their documentation. Remove it.
> 
> 

Applied to libata/linux.git (for-7.3-fixes), thanks!

[1/1] ata: pata_legacy: remove documentation for removed module parameters
      https://git.kernel.org/libata/linux/c/a19d4f9b

Kind regards,
Niklas

