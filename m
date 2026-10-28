Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201826;
	b=c97MXLjIvfBwgSD/1lNKNBC5ELaLUf2xtFvv7QDEVB2XukDfpuSuHiGoLC63uirNwHd9
	 P4v5CGC1Uc1uHtvaCueyFEbpRNtcNA7+dpU54RBFG0Ean3O0SfL6xUfb6lXr2wu+e9ygG
	 A0nry02ItX+HgU6ZzSoeSbM5lLJv8auHeRoMOQpur2Kwza6GkuNeMeqL5UOmA007NtCXO
	 4gpJOIkB7sTo7lhkctqmyueI8us4Iwj1cg6BMKnBw79bg2D7O3FpvnTDtOaz87s+Mz/8p
	 nQjYDfd2OfAQJPZWIdK6KdzSPvSVoI3gEFRmlyfOS0RBsG6I6n/FfhpbmnN2C2FuWhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201826;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zbMLBeO8YaZ7CmIsgiRZHC8PlVU0JzY8Du4DFL3FPRM=;
	b=2PZCbIIHSsuKZ0JavUrNggKUQfAUp9wqDxshP0eJlVbjavYtKeTGHKCpMBxNyQY4Ug92
	 fvJz2K+L4/7SzVt1ep7xx2Hkhliqfh6bJagQJ9GHSFzv5iDq7FyEuCnNcEHeKIrnc0EAx
	 gyubAUkqzwWjAIHn/Cy4SusSvn2CSYOJU9osbIYz2lq7jZb7CfWTqTHTYlM07qCpRMRWJ
	 I484NbffiyDsUEN+55tCgaiNqqNfu69HZpzp1oFfqF0WL3cCnm/Uq7QtTju6MfoMBvGNI
	 QPG3ceHwbNzxowGftszjhCDGUMghA3oL7KwlRuDKZe2IOzCFrYwzlnUZtetIPVEjvTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zl4gLEd0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE8606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zl4gLEd0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8AB1F01828;
	Wed, 28 Oct 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793201825;
	bh=zbMLBeO8YaZ7CmIsgiRZHC8PlVU0JzY8Du4DFL3FPRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zl4gLEd03jzTt4UkM7tvIi8o3r4O2eHeg4OL8Vb76CzmUsTDKWIdrbNW7nkhAQELF
	 SO9jaG3c+qc17uOcKYza4Ldxs0UfHK1rqNy3eu6a8oXC0GalIY1EMZxC0A0x3FStkA
	 bBsmujB6B6vch/6S9BdU7xE3bzeOX4O8JVfEUzlpNOC9X9UUTvfRVdenw5Aa5jb+yn
	 KSI/uyXG1hz7jnliA4ba2kDlTVUIWMQkftawVaeEguXDFPB9puA0kociJjwapK1VhO
	 KUsGY3kM/zJ16EKf2BP7O0pt2YwnZskeFO+N/vY/BzM4fb12ao5/Q8dLFRg9B5sCHl
	 RFJW00dpX4kYQ==
Date: Wed, 28 Oct 2026 09:37:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: bestswngs@gmail.com
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, xmei5@asu.edu,
	stable@vger.kernel.org, co+e015e82956da641b@bugs.sh
Subject: Re: [PATCH nvme] nvmet-rdma: reject short connection requests
Message-ID: <auIWoGsLbOAXPekV@kbusch-mbp>
References: <20261016172336.286341-3-bestswngs@gmail.com>
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
In-Reply-To: <20261016172336.286341-3-bestswngs@gmail.com>

On Fri, Oct 16, 2026 at 10:23:38AM -0700, bestswngs@gmail.com wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> nvmet_rdma_parse_cm_connect_req() treats RDMA-CM private data as a
> struct nvme_rdma_cm_req but accepts any nonzero private_data_len.  The
> iWARP path allocates exactly the peer-provided length, so a six-byte MPA
> request reaches the parser and the hsqsize load reads two bytes past the
> allocation.

Thanks, applied to nvme-7.4.

The sashiko complaint does not look related to this patch and can be
addressed separately.
