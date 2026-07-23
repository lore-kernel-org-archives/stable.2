Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C51314A9E;
	Thu, 23 Jul 2026 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788384; cv=none; b=FWORtfiQ/7M+bzdrhZuFAifbxslRU3DQnQMXbd/QqQjAxGVYYkO6qGIIsDQZAL9UIMVFzqAbapi4EQv/AQKydaQ3CKq5pDvCr476rbsDpBEFysYgQYtL0g0Qa69WsWGjsjH3N64h9BFTLvxZKoDb3RFAIJTaEISAmavBZwlF4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788384; c=relaxed/simple;
	bh=tzBPm0P8FtJhS6bipwEKUyI5d3W0ud1o43rAY1ZBYFU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O9POl5TDwhQD/KNalGs3h6FV9tq+WHAqL8vwH3gWevVgHnK2kvRu8deN+DJXHTB8rIdBIH7s6O8+SUerKhC9DfViZ5RiZCCEUOfMHUjvVVIRIShOXBtM6So6SQck2wpJpnEQZmiw9/b0U1jMpuhTAYDChCw1t6/xLVfQUvfFQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTXYXJJv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTXYXJJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69EF1F00A3E;
	Thu, 23 Jul 2026 06:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784788383;
	bh=LOUI7zOM4fXhet323bIMOQ5HL7eLMArXAK7yAqcwUlA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=kTXYXJJvtx3a0qaOQNy0xiKIPrOFxn04+oKqEM7b7j/bKBJTvRmCJWg0W3U+0iHjO
	 KdcIZ/mzhtg+J4aazVBlwb9WmyCntal7SAJOPe6r5SDzeA6fZcKzoy9CPhgQv6Zf2N
	 WuQJE/iXXTnTIE8QJ1rru1LgsgGLq0LRGDPCzPv4y65av9ni0w4v7aRtElZ1v2E8q2
	 X5mF+AI4Om5qWXLUUTg+vNdFmsDOmnh1g96CI4WiHin1xw6jUg4M2vkF4UHNS1vVCw
	 nhTnBZ+/pcHqvOJkLzBj4pzpIBLDBJEtMUcMBfDk3amV//PoXRpXS0Qy5+ItxlCuaK
	 2K0euiCu5fczQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id BADC8F4006D;
	Thu, 23 Jul 2026 02:33:01 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Thu, 23 Jul 2026 02:33:01 -0400
X-ME-Sender: <xms:nbVhagMJMfLmQK-SPKIZkvqTfRUo__yZB_bzbvi1DluuN2pzEcytTg>
    <xme:nbVhahxcTPFXx21orpCSapWe-FlrrYBvU0CdN1fQfhfgWSUL-tQtfM8909PzyloMA
    WdZMZxOyY333qgEHHX_6Tb9XxDRgD0Du-JTZHb3JiBvPkLlM-f_Yo8>
X-ME-Proxy-Cause: dmFkZTGzxgQsIghbX4M2UiidHY+72dk/CGh0YVHz53jt4+zt1NX7kzEUb4Aw5GxxF7/Npk
    ozbdVedTKeGdpjTBkhQPKwd7ekFbtpY00JA23DBoHvr5PKD0WbqRyX/C70qV9OVfsV8mTn
    z8zE5mTJKav3Wv/F8aqYAIBeAUXcHKW2qzt0odnva3OMU0ODWvZWJ2iKnjXz0r9nju379x
    rk2Z8b7xUXfruCPvfDAlqij5Myz97Vk0xvpjp0krgFphl9nQ7XptPla8MBmKx0VL2OPVjM
    biDuTnJvm3eI8+6yYWDD4WGsnZzNnkhR1OmvZToPa5+JwkPTXDPIh9DejC3OQDaGJWU0IS
    6iZU6nASxn+JEorLOcwdGi4yld8kQ6t+eQkrfNL5mUO9Ma7+d3j4bL2f29do675L9nSJjw
    YFbNYclFTlEfWG0HS60z21BU+fP8JSh04ZdI71x7lMIElNI9GLwWJ69ADkbb37vpAyzpXv
    f0CTyiDZ3S8R8+YocXdqeGpDekzJ7yLQQUBuKkfSGKby1pBRh4S6ls5Go9Iav0zwaVIKZn
    e4njhoryRAg+i6uAICW1sLAPHq9XLWRscNNDY5cfBaCB3V3qaKDckYHYSiLIRdXzg9Elgo
    gbvt/ndcsm+ZLE7FoqJy5hrCWoxwReubEtahNQk0xwrCB5+qd7U3r4fsR4zQ
X-ME-Proxy: <xmx:nbVhas9IrqbHTvoqX7W2gQhaTrfRtU_wkq15wZ_w3pjDdNXdFTp6mg>
    <xmx:nbVharOZ4JPAgiq3kyu6B9cbVU6ds8pUK0taje4x13tJbNuHNqgYIg>
    <xmx:nbVhagBOpkQT0TBXjj7zpjKq1zF93XfVaKgB4n-QBdktZLmQ5nXjkA>
    <xmx:nbVhavOBjZrfdYkLsn3OfnoATsRGtxb983GUykDpelfWNLdhDtpTIg>
    <xmx:nbVhaneJ8vAIfloQKbdW9GsT9CjTsfHTDV91L_2omw5uM9GULx37Szv1>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 87763182007E; Thu, 23 Jul 2026 02:33:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 Jul 2026 08:32:40 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Nathan Chancellor" <nathan@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Message-Id: <592164b0-9a0b-40f7-84ed-26705dca8408@app.fastmail.com>
In-Reply-To: 
 <20260722-x86-boot-compressed-disable-jt-clang-v2-1-7373d38482fb@kernel.org>
References: 
 <20260722-x86-boot-compressed-disable-jt-clang-v2-1-7373d38482fb@kernel.org>
Subject: Re: [PATCH v2] x86/boot/compressed: Disable jump tables
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, 23 Jul 2026, at 02:09, Nathan Chancellor wrote:
> After a recent upstream LLVM change to start generating jump and lookup
> tables in switch statements in more instances [1], linking the
> compressed x86 boot image when CONFIG_KERNEL_ZSTD is enabled fails with:
>
>   ld.lld: error: Unexpected run-time relocations (.rela) detected!
>
> Dumping the relocations in misc.o, which is the only file influenced by
> CONFIG_KERNEL_ZSTD in the decompressor, shows dynamic relocations to
> some string constants, which correspond to the string literals in the
> switch statement in handle_zstd_error():
>
>   Relocation section '.rela.data.rel.ro' at offset 0x277b0 contains 31 
> entries:
>       Offset             Info             Type               Symbol's 
> Value  Symbol's Name + Addend
>   0000000000000000  0000006600000001 R_X86_64_64            
> 0000000000000000 .rodata.str1.1 + 73a
>   0000000000000008  0000006600000001 R_X86_64_64            
> 0000000000000000 .rodata.str1.1 + 78e
>   0000000000000010  0000006600000001 R_X86_64_64            
> 0000000000000000 .rodata.str1.1 + 78e
>   0000000000000018  0000006600000001 R_X86_64_64            
> 0000000000000000 .rodata.str1.1 + 78e
>   ...
>
> This optimization is problematic for the decompressor environment, as it
> is built as -fPIE without any explicit absolute references (as described
> at the top of misc.c) while not applying any dynamic relocations, hence
> the linker assertion. To opt out of this optimization, which is of
> little value in this special early boot code, and to mirror the other
> x86 startup code in arch/x86/boot/startup, disable jump tables in the
> decompressor.
>
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2165
> Link: 
> https://github.com/llvm/llvm-project/commit/fa02a6ed66b1700c996b49c96c6bc0eb014c9518 
> [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>
