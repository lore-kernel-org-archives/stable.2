Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358855;
	b=M8d5WtjfC/38oGOwuN2Y4Z1ZpbO9wMFY3QedwkthWmhXs6fbC/1UB+kTG9z6YB64d306
	 puQFpKeU47o2OSckfWpQBbspcbFMdk4L6fe8078D2HfNYocNzG1LNYt5Fk5gC4gw2Ij5w
	 cd8rb93ioQqWffjIyFnL2O35zGXi2eA+qLaC3AgXeaaoE7cPaWu26u2qmKsujHVR6o2+j
	 OWiX6xtHltaXVdI3T0wZGX9yuFuXn24F3CNf2nJLK9VLF8DLxH9Rv/AxnYhDx6yjMqSJ1
	 9Xs9lT+cu2KRvowH0Sfg6GARyPlMhnCZDBJhNaXLwdhvWwIMZBEVB2WVI4KY++uCmrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358855;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=b1KYN/Lwwltx8lsEo1ijSFDSSBnaiZ0WaUNnGosleeU=;
	b=eUsXLHyfS7tdOzwS9iZI7TFyWm1D/kF1E1OA67fWo8cv7YWbBGQy3xWmEhIW5VsYdhF0
	 x6nWA8hCcqp/+13Ja6SPL13TnatCajyGZjQwKcarwD6c158T05tlJe2iPW0BZBZFnd7eD
	 PYq9UhnXYCfWg2WNGdMvwF5AzaWWoyTPdlnctGivaaaGVQFQ5USywnIguw6u5121UDxAJ
	 kQeZDPkqqrJFnQrCr3qbMSTOML0eSPYtJjV8ZCOLTu/O7PaaEW7tYt1u0hbah91uHjFYL
	 Fg4mlFj3PaffFB8BytRrUdK02m2pcg0Bpbv1oTBE6R+T6hyoKgz6UjUsKxR1d+R6PRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zm9eYVj4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA058606A31A;
	Fri, 30 Oct 2026 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zm9eYVj4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1BB1F00A18;
	Fri, 30 Oct 2026 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793358854;
	bh=b1KYN/Lwwltx8lsEo1ijSFDSSBnaiZ0WaUNnGosleeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zm9eYVj4LdURXeRBijkxLOYixVbDjIuCNzhwUyClUdnLrvSz7zanXkYKW0xlRkZaA
	 1l/t/GdQzMxZdNXkj6YyJBzS1GBWAMo3kodyhM6TmvAwZtWSGWAmp/SLbnaH/oI/7S
	 D05GKb2EbQRjoQuCFyCimWG6n9ZKyqYe92iyzxGrT8uf8YlaFVaIhttRvExMzYIuac
	 lPr0hiQ9vHPXWfQegXj0Ean1pbFCMA/ky5UZPBuG9jy7yJ3UHH+3+acg6Z/N3pvV7A
	 4iDonYgXwQzLJb5UCz6b3ZmwxDD9JGVQlBKlJ9Qg3A6VkuFpFNWaGQceBxUps3GVVs
	 3Y2lcVa2Ok99g==
Date: Fri, 30 Oct 2026 11:14:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Vinod Koul <vkoul@kernel.org>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 05/21] ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA
 before closing BPT streams
Message-ID: <c56e07ba-3038-466c-9eb6-1cc5e23afe2d@sirena.org.uk>
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-6-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fn8/WZpsIpVzSicI"
Content-Disposition: inline
In-Reply-To: <20261030104840.3361217-6-lee@kernel.org>
X-Cookie: Orders subject to approval.


--Fn8/WZpsIpVzSicI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 30, 2026 at 10:46:44AM +0000, Lee Jones wrote:
> When sdw_enable_stream() fails in intel_ace2x_bpt_send_async() after
> hda_sdw_bpt_send_async() has already started the TX and RX DMA streams,
> intel_ace2x_bpt_close_stream() invokes hda_sdw_bpt_close() directly
> without calling hda_sdw_bpt_wait().  As a result,
> hda_sdw_bpt_dma_deprepare() tears down the DMA buffers and BDL while
> the DMA hardware is still running.

Does this actually need to be in with all the Soundwire stuff?  There's
no immediately obvious dependency.

--Fn8/WZpsIpVzSicI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrkfAAACgkQJNaLcl1U
h9CU7gf+PrfLJvFsZ/VgKNswGCtY6iaRMKNQU0qw4VXl8KLHJiXvr27ktz3ktkRi
v0QPBmsJb1IVNTC3gJ3D6Kb1hh65lkP8Dt5kyOLSCMDZQun13ncRdCzvTmekPA+B
paLrSael/TJmZUYLaqqPGOAy+iIZSdQLdm0auH/SwyKJ7b+zbnQtcD8aBQ2j8boJ
poUUr3OujFJmO9zlmcXbBOWH/PxX1XNUZ5MxC3TQoBsjxm6pTjyqf8de6zHqfkYJ
IkMk5jG9JE1fbZYonvV9M9mgKDTWo/6xePYivSoCAuj6PkOZPQTw3xjzJefIf0xw
ke+0vaXO/DvW7deBeZGYZL8KqVyQbA==
=45f0
-----END PGP SIGNATURE-----

--Fn8/WZpsIpVzSicI--
