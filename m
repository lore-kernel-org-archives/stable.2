Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597006;
	b=Qx7jqHP8xhLdrTH0NxrCLlyhVvNet8zYGISDKyjBCTqV+JEB6SQKaZO8v4QdnbSVdbok
	 7SXiP46uWK3roRtQHx26/0dXTD9AVSO4ZumhBtFkEogyc6aMUFB54twj0IqdT/6S6ZfvX
	 Zd/Fv1r209Lx9f7rmxYliWiEygOkdlGi8BhoBNCxF6lnrf/n3ejCa7qvNrnkre1NPeahD
	 +UHSjaavZ7oFtXvJ07OHP92lmewOp/Cj5G0jUxyC2DpZ+bdqv/b3mQXQ5QSdClfiRBnaW
	 heIK57qZXIaMiwtpiK6zwZaz3bCiiSoZz+HR9lgpnqTEQ4bXbRWabENxIdbTqJ54tFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2ifTHgfnBtxu94l8pcb+DqckBDKon5AgufT3kQx4Ynk=;
	b=Kz1DdOAyFLz6Uzr9zq077ugk8DDE1xFi8+WfKM3qqt1r5wdVYKhtkuxhokGNifN7YnqE
	 ZYvfWe2zuEEkS0p8gx4zjCDR/vDt6wHseRgHS8A0FbFfr7tt2EciuDvfIzkFlJ5OJAXRM
	 UE+4qEKsZ/5I4/r6qSy59sfYpN7UP/zz5b7a0ilNN2Z+zTA+UjZ/8J1P+BFo/QebZ8owz
	 onchRZwLn7JR0c14kw+70gIANktFP6cFC1Q1EiX7EFpXlPVTc4q4/7WwMvY4UpblE0UBn
	 tYHYJBbwz/AgdGjzoetqfhw6hhJy1gmG9bWx7+hNfJsoTMXhXmAaAblA3mseVBSMbUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NACfqRjC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB59606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NACfqRjC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0451F000C4;
	Fri, 13 Nov 2026 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597006;
	bh=2ifTHgfnBtxu94l8pcb+DqckBDKon5AgufT3kQx4Ynk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NACfqRjCS9vg1HTGvooDSnA0nVuYj5d23kHREL7FGtBoi52t7BCfYCD9QMb/QVkbI
	 qZL24iZhhvmLKvikrPJIVmB3eRPrKDTo6ntEOW8pFERY/D1W6icZce8uJalFOHPbd0
	 pfl1VDKWIO12oote6j5g5Po076dZ3P5Rqu7OdUMjz/EfzggPbjVqidNXsw1SP6tzYf
	 y3/ABE4JAr4FLTrNg0eVmvhcRXmPIWBd3ZfZih/Z80OLLwHR8kdXK/B96J4kDTDmBp
	 li0PSrhTRrBZN1cvea+O5emYJZb9x9lgzlJAjIvBBBVoKFNpDWIdjjCmnkOCc0NUiY
	 PE5+rh3kdmO1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	cel@kernel.org,
	bug-report@moonshot.ai,
	yilinzhang@moonshot.ai,
	doebel@amazon.de
Subject: Re: [PATCH 5.10.y v3] SUNRPC: Copy the deferred RPC Call from the head buffer
Date: Fri, 13 Nov 2026 14:09:51 -0500
Message-ID: <draft-0001-redoebelsunrpc510@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113102638.2399947-1-doebel@amazon.de>
References: <daily-reply-2026-11-12-5417451315@kernel.org> <20261113102638.2399947-1-doebel@amazon.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 13, 2026, Bjoern Doebel wrote:
> Subject: [PATCH 5.10.y v3] SUNRPC: Copy the deferred RPC Call from the head buffer

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
