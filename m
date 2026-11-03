Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717545;
	b=cY/B56GnpKRLuAr70vssiTcUBFdRWCF39m/M45sgVrkcps187PSryti1RsdKhxobpmID
	 wnI1BeitSldaEigayG8CPUA9lGARCY4mM8XuPevT8flADeDAD3x/BBJw4O8LTa9qrl3pz
	 5AnkTzomm/MexPZ9NXLUg5K75rGCEYw17Ndgf/d/OvKNDp4SPQo20Gsh+LiAGuGTChal1
	 xS7CzxgYSLtcci1llF8cO4XUTsQYsftt0vmWXUtYeuMV7P36dST2EGmK+196kd1WkqIF8
	 1wXJCw/fZXpEiTzz1jUshosz6wKGAx7G82QgOHjrBNnbzUKL4B84jxIA9hZsTQsCzNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717545;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pZDUQoAPmpcJQ1MGXQerdQ+hsS67diNlOCyUT7orJbQ=;
	b=Y4LrAKxUWnUhsYOYd2E4ArZWNAyW/eGbe3M30D6KInMvx98cGwTVV27U8qQTl1ix7n7O
	 V4Tp7iG/TlSaAtiF+TvPuDkjO2Z5BNzjcRoWrdh4jU7Wj/ThlEXpz4b3H2KsQkiRon1bi
	 TW8gKYWSmmJMkSBVGJJbWFA4s4dSwYu89EHzhh0uEv58BBH3CFb3fuBUodB+66585yfdT
	 ZO3G9HEOpDA4D+gYObP8Lpyb624XqnDUvgtGtHUrxA4zm5QcQpcHifoxKQMw+Zc44hSMR
	 hSK9ohlpBd43MLoj3lFP1r9PbrcHCusDRcgBwghoDJ74IsMM8hwGQd0Hjs2SHzd1lLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=octuHE56;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB64860A261C;
	Tue,  3 Nov 2026 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=octuHE56
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6A11F000C1;
	Tue,  3 Nov 2026 14:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717544;
	bh=pZDUQoAPmpcJQ1MGXQerdQ+hsS67diNlOCyUT7orJbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=octuHE56uzGrBMrp7166rFZjq/wnXaFsTr7IIG3zl2GxEZwjKr17pIkusq4jp6mXN
	 mLEaqJM7SSf41A6AgYFmIZSHLCOBfnRcPxwmUULylluZ/BtRPUVjiAhtcuLPKVSi8+
	 te+2tpxv6FIBDHG1hYbsVtXZrzYfb998Izoxf1NvzoAEzIvFOpHEvyk3y3Xff+4FC/
	 o/2WA1kg2cgbqHxaU14o+r5P5lHoCTKwHyVmQ6QfVLsEAZLp2hO32QtmcUI3/DsuhI
	 KpfZU6WyBhlTVBcgfdQLleBesDDuY0BtMKsH1vepW6wDZUm0XmilXXv5giOikKqoJg
	 4HoslEFTZnEhw==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tom Zanussi <tzanussi@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Taeyang Lee <0wn@theori.io>
Subject: Re: [STABLE v6.1-v5.10] tracing: Keep the predicate limit separate from program capacity
Date: Tue,  3 Nov 2026 09:51:58 -0500
Message-ID: <2026-11-03-1-daily-reply-0010-re-tracing-predicate-limit@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102122714.656104-1-lee@kernel.org>
References: <20261102122714.656104-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Fixes: 39f7c41c908b ("tracing/filters: Enable filtering a cpumask field by another cpumask")

Not queueing this for 6.1, 5.15 or 5.10. The overflow needs 39f7c41c908b
("tracing/filters: Enable filtering a cpumask field by another cpumask"), which
landed in v6.6 and is absent from those trees. There calc_stack() and
predicate_parse() agree on the predicate count, so there is nothing to
overflow.

-- 
Thanks,
Sasha
