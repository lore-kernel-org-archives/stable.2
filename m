Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678149;
	b=T6bkANUaAFS070sT9Q1poV3UsbR+LdJzaTE3KpcKw6+sq/WFM14Z/i0//olfA8HWh2ft
	 s65ImV5ZBTjrNbJFENFdcNqx2XTW5bpZcRn9k6cmRVKH2Znl+xpQjI76Zb2rj30Vba4c0
	 opoZZzlEO2x+LjhcwvZuJgr89CBNyRH5+Tkk4HNIIgb1MVf1Byh4I9EfzlReorWyP1l27
	 fP8rPNibxpTUOFkmspYdIdLXNIHsQjDdESqU7ITRQj2R5u3j94zDeUMGbBnidsg/cf4iA
	 OgFZVT7R+ithHYlFnoe2Ndl8JWRQvnJ6HFF+jZdXpOvrpK+wsJb7l0S91UT0TlqjWIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678149;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GR7kfLR3XAUya2R6iugIuY1zx7T1IiTUtOZ4j6iy/Po=;
	b=KZJL3u64+MiKnPlp/HrGcGk7TgEjZYRvYZ7fU3V5/CvS+LfNDCYAgTj/x8kqG+G4J1wJ
	 oObe2Yabng+alEVVbPADcT40ub99GapJ53vY21Rqt6z2sPXRwWe0JESq/jTPo5JKltsBZ
	 aUKf8k5SjDN+9RLCF6Yn3fexwHocW00vu5xoceF6pAl/hJECxZfpUnaeZ9autC7n9qP+i
	 noo4JWztKf9UlN2e7z62NqZhyhZN+DpJCYgO6Ii9cQYtXfb2Q4PCHM1s8hmMfFXjuo0Z9
	 U7ooczx71S9UqOglTyVcpjkHkmVBPk0VQ8hrPIMWMwVMyQZo/ukgHwB6j/g7s8TUuQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivWgt2f4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30881606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivWgt2f4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACAC1F000C4;
	Sat, 14 Nov 2026 17:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678149;
	bh=GR7kfLR3XAUya2R6iugIuY1zx7T1IiTUtOZ4j6iy/Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ivWgt2f4RTaJRfIoqlUal1WksM765cRTC8U5N3rVySWuYK+ybESmSW7qQMCdcvv/L
	 BK9hTW4kiXV+UTEkRM04sc8RklFjf3gmU0ze8m6ywB5dcVaLML0XsF9wiNqKGgwqBF
	 XTCT26rbDZqif4Tz+rNuGMmIeMnlTO46WoixYdoMUp3MJ9tV3n5e6/kZxGjhBHUJQe
	 6+09K0qaezDhOtGV1C5ENktUpjrMkXAJp69PaIcQL+oNGSPMGzNdb9cpXrwtXI7qzK
	 83c7e1jvEM1ghbtOVZH3ITspyuYtrn1wnKUKdlJHIY7aG68Qy5hnmubb5OXY9FP+g5
	 kHQplvSKKo/SA==
From: Sasha Levin <sashal@kernel.org>
To: Marco Schirrmeister <mschirrmeister@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [6.18.y] Request: 10a47fb67340 ("tools: linux/types.h: Add 128-bit integer types for arm64 UAPI structures")
Date: Sat, 14 Nov 2026 12:42:15 -0500
Message-ID: <draft-agent5-0004-re-tools-u128-typedef@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avcSVAn5Q724e-yp@eagle.home.marco.cx>
References: <avcSVAn5Q724e-yp@eagle.home.marco.cx>
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

On 2026-11-13, Marco Schirrmeister <mschirrmeister@gmail.com> wrote:
> With
> 10a47fb67340 applied, 6.18.63 builds again without issues.

Thanks, that answers it. Queued for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10.

-- 
Thanks,
Sasha
