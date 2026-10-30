Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372840;
	b=LywMf7ymy5G0XMeNTZZcA+luqVIV0XaGlzBmmYqR7OThFLcfloFYEFn8mE/AsnKs04Ei
	 cvtovUj1iOWSrrg6YlgLXlUVOpRTvjA6PYd2Eu8CeD5thN8kjFWYjG4qu8Et+vlFA6Xid
	 2Vjbj97AheDeytxr+GSlZ1Trjp6ps7losjTMJ1X7nSh2gk7Yw7akJCrcAh5iK2O/e6NM+
	 yTyC4Me5bQNzrqWHwdgTu92sIJPTpePXPImvH6zYen+p7ov8kB8rl0fGoYVLYRnSGOOhS
	 TfbmEXBfPBU+zd9UW5ZmuRnZWasztjj1SJQWO2YFXcpwi9k0YoM0N86xOnQHZNnjqhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372840;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=aaOAKoZaIEKsIzdZ0xdbS0RXzzXtVkV+jQTAE81qpAY=;
	b=LRN4r/d7FanCThHFGXfPg47GhbTfwql0Lpd83QvbohLTOAw+d3DHABtC8PFzCuVGjZeS
	 kFxAY+NMBvICtZr77O9Q0WtFfnCNrWyZS4te2nNaF/y4oRMY8mCu9unsq7hPaq1SHu//e
	 FcQbz8JUFfaj5bbAokcywdPgogY1hKAp4iup4Csuc/CBZQLQV2sAHWEO6esGw4S+1IHJQ
	 0bJvHk4QEy3z/8xmYqkfdi9tiJ41AHaB1JvPN/uTHGej6a0Z/OUpGRDHNMPrdLs/0BI81
	 fgBlWeYO1uDJ/+aTMniv4sHVCLYI+waRol9p5e62b4FmHSnmrFvmeS4DTp87Tcgvrog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UD062HP4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAB0606A31C;
	Fri, 30 Oct 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UD062HP4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE3A1F000C1;
	Fri, 30 Oct 2026 15:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793372840;
	bh=aaOAKoZaIEKsIzdZ0xdbS0RXzzXtVkV+jQTAE81qpAY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UD062HP4wTnc/5KC6Nab2NkgKztXGi949hgNtJ6ubC2G5SnPW2GqYQoz5kCK1JWz/
	 WQmjMUgneTxb6tBLNWXilNWlMWogRWcq2s9JHm60/uPz3utJScbkg0QLfMrc16o4Ok
	 pXadadfNdgi1utyVxX5VfKUfy268GKiA8H8ipfa9QSMVSZcgKY9Hhigtrqy91VdUtr
	 lHlEltUM3MbRbw1UhJvnQxHDFbao5D3SIdNsa7NfIARSda4Z19QE3PNcKDFWDfjA16
	 p4uruG+40rl26n35JWnPfIvdyi1nfHxfJd/epgI5BWUNOB6gxCG8yPg8RqylwjyGJN
	 WUzxACnqlyx1Q==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, Hungyu Lin <dennylin0707@gmail.com>
Cc: jack@suse.cz, akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261025171130.16115-1-dennylin0707@gmail.com>
References: <20261025171130.16115-1-dennylin0707@gmail.com>
Subject: Re: [PATCH] libfs: do not extend i_size when no data was copied
Message-Id: <20261030-erzwingen-archaisch-wirrwarr-5a6d0fb751ce@brauner>
Date: Fri, 30 Oct 2026 16:07:16 +0100
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
X-Mailer: b4 0.17-dev-ce4c1

On Sun, 25 Oct 2026 17:11:30 +0000, Hungyu Lin wrote:
> simple_write_end() updates i_size to pos + copied even when copied is
> zero. A failed buffered write past EOF can therefore extend a ramfs file
> without writing any data.
> 
> Since prefaulting was moved to the slow write path, this is reproducible
> with a one-byte pwrite() at offset 4096 into an empty ramfs file using an
> unreadable source buffer. The call fails with EFAULT but leaves the file
> size at 4096. generic_perform_write() calls ->write_end() with copied == 0
> before trying to fault in the source buffer.
> 
> [...]

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/1] libfs: do not extend i_size when no data was copied
      https://git.kernel.org/vfs/vfs/c/4a1edc38b617

