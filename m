Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AF318EC4
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717413; cv=none; b=tPGpBzBnS/7vJCXeNb46K1PBBgufauEODb9/frBmFw2zmMBMgIOPS8yTB8qe8c/UxZHlidBYit/g/vwMFqvc+UT8LellBJZcE3Upw5+DFdrG8chMVmqRY0G56bUaf3MGYJ0FUn3HSTw1FuPxJU7ValCWQwr1YILPHWZA6rtX19o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717413; c=relaxed/simple;
	bh=cgiNL2CtpQw8SDZgvgndOl4sBlr8Wbuimrif+QjzgXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ii8DUT/rm9nEPIH4y686Az3gLeds8G9lViXRE43Qohaw5fHfqR7QT4Bk/zHW/xT5mIw5jYN1GY7asGPbUmN5XQtQXdtNX5JCFXRR2sPyGWTtgw/Q9xTOCs4cvWRsbKAS29axTaUkzRBv9FC36ToPLtFqhm7sW/bVFKEMPY6JAhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjfI33qX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjfI33qX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CD21F00ACA;
	Fri, 10 Jul 2026 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717412;
	bh=a2JFM6Cr2jk9GrHLFje8y09AuqtafrU/QlUJZvizf1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PjfI33qX1Z2O3n4dCIAw8Gtdw1GHpVgfxL8AEUHPVrtfGHKz21PZ0NSI0bK1vQ3dG
	 CnvJ4yFZdLNnZfHE1tQHWlkChkm0QUrm9ZiBSvKkn+QbFo/y75ZZ0wmGqzWdHD/6fc
	 MGJk2eMvruguWv5sa1TdOM6K1kyytc/8q7o0lP3WSu6j/J6JORAuJbD2CnHlNVO2F6
	 TBYGp5My1pt7iqEA8j/rSqE5lQdIthFvv6kSkfEoLr8FF20uECVZ5oHPqePfyE20Mh
	 cEjyyR7I0AuHo9ZAnQ3fiwhtKREaIsP3WhT5JiYb3qYIm1F5KQE34JQ9CyNZC1Dlf7
	 H3mq+4CrAVryA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.12.y] rust: kasan: KASAN+RUST requires clang
Date: Fri, 10 Jul 2026 17:03:05 -0400
Message-ID: <20260710163023.agent5-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709180359.130168-1-ojeda@kernel.org>
References: <2026070939-unworldly-mantra-5611@gregkh> <20260709180359.130168-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 09, 2026 at 08:03:59PM +0200, Miguel Ojeda wrote:
> Kernel KASAN involves passing various llvm/gcc specific arguments to
> the C and Rust compiler. Since these arguments differ between llvm and
> gcc, it's not safe to mix an llvm-based rustc with a gcc build when
> kasan is enabled.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
