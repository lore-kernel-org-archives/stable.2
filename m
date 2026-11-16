Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834124;
	b=G1p32A7IKSoYxmxuGSVsVpjbg+ZwRxOBGJbdPQ0i/GRbCsw7HB2lwAMZrBxrHskoRzvY
	 wBZmq9kvkna8R72sG40kMy0Q069T8AhNis/qAyofSkjlnqtgiuJSZ/Kn8gJFCMVEhikJv
	 yEzr7SQk/L1VaakU0FNQ1Pp/XhoND7FZzPhJwxWY/I4ptGIwIJtsEFT8PKNO0emSiQo4a
	 smwfLBSmY/7jz8LZBuSxQ9M/nTgLw1SztxPvz3LQbyAzdIHpsnbM66YAgmG8wjVTbPtg4
	 uflb72zritCM6BpUh3H7qwdqWFxyc+v+QWlgYGzMc/u0KftDG2rRwMrJhgHq8ThIZAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834124;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IJ/JYxOYamaVX6BKoUyK2Em6ePyVAKI0f1ueGvDFNCc=;
	b=kQ5oJwGzR2pNSaLQpGqHl9GfKUuYIT5ZALiWD+iVLOdfNx7FW5euFPkPrPkj5NNLlwbM
	 Jmnb/xA2/+PlLdoDJV+mr1vZJZTCXlk3vYGUbbv07BrztG/qsNGebJleSYATmbsfuntbe
	 nWPDTXqBiUpTFPmz4GT4AN5DdwKc5r2pCimo+tXCKYab8pK/DEypv0QZPd7qCl9FXmXTg
	 Ev081DlyzRfb8a3yJeYLctrbXXAQ5vk4UBVxqtOHVcCGRV7zhoStZfNpaP5ZAmxCh7AKd
	 +iuoYkBYDvz/+HZBXOaDdaUUNr7FwLlymAU48yXQdqU2QxOSyIQAyqc4XAgwjTUuU0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKOHwrPa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F08606A31C;
	Mon, 16 Nov 2026 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKOHwrPa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281C71F000C4;
	Mon, 16 Nov 2026 13:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794834123;
	bh=IJ/JYxOYamaVX6BKoUyK2Em6ePyVAKI0f1ueGvDFNCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HKOHwrPaoCu9Xn1B3m0FyfWipmD/bTECv8AQ3/RAOQq+hTxqk4YQ95J3t3DY8phMA
	 PL/Z1rFUyRP0ZkK7rY0DyTInSKxX22wchijA+jdU6Csu49y01ETEXXDmNhwMJViXt0
	 bAvdjc4wL8q+qJSaI+DQoRRP43T2BMUcpvzvLLhMRG/8GS8jMTCpfL/6PR0To1Z3KL
	 enqXcqOkoqbes8eFFmyKwsRUmJrbNjCqkLw8QCrIaRaFsetSpSVLwMD+NwtQBJK9YE
	 gKRNy8plojJHBh9jSkDwacBnV3DSx1oQoebiIS2QKZwjEedlVIis3sbAGbNWfox2ga
	 f/0LxLRUAKP/A==
Date: Mon, 16 Nov 2026 06:01:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
	x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
Message-ID: <20261116130159.GA1327949@ax162>
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
 <avrPcQ4sOkgJPbkZ@gmail.com>
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
In-Reply-To: <avrPcQ4sOkgJPbkZ@gmail.com>

On Mon, Nov 16, 2026 at 10:40:01AM +0100, Ingo Molnar wrote:
> Can we just limit the feature to when host == target, ie. to not
> work it around in such a crude fashion?

That was my v1 but Boris didn't like it:

  https://lore.kernel.org/20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org

-- 
Cheers,
Nathan
