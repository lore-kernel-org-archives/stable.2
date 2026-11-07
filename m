Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794054653;
	b=5n5EOXw7xRT7FJjIMQuP3dTdd+PWzUcV3Lt9sral+4s9+FsnsrP9dO/T5jnhOcuf15am
	 958mC1L1Tv5c/DW5r0MfFbrAFfeRvXYj9RBqFTPN5mzUYTXTGtDLXHvINrImfy3p6P/nl
	 IHcyy4m0bkew728U4yjZceuRHKP1JvIHGpAI9Zp7zPF0Zfx48BpWngLVOozcrLD5quA8z
	 ehK98Z0p3wU6i1IO/yBmda9f+gbfTEjj2sGvjMSGEuk3IxzUcKCxkOGvhvQyY3MNcIesF
	 FUqCoOt7JkQSOgZZv3FgSz7x5oFXYyan2P0Vs/3rQ25XTzTHPdL1GMiIWxD1yfcbmOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tkP1cDv9Adap7kp7q6vc7WrwggtMzAS7jwFRNTqiTKs=;
	b=cEqzuOVMfQhuWzBSGW8w4jr+1O5QiCs3od2uCzgnOCeJjyDmeFGjpKRCoCB3UZLecww2
	 VMEjI/5Ie7VVgxE9NgFVUAfp6Rt24G4r6J1NAQfmOjK7PCnj/z8vqpAXVbsEQHi2BRsQe
	 DPNNrwVWcbq9l7o5IcNzXfHU3ampu4QaO/GJt9j3qq0xWcb5H1SQ9kXaQyPpweBoRaZc3
	 s9qqG1joJOqQj5CXlNpxqAblsbDCd+xaniryj3D7v5kmV/mUpJwyxMNBFlq0Ca6SNiyV8
	 kEYhAN15Tohe2eY/0nk006PYLENxYbO4g8tpgvtzjtDT68DZL2rq1BppEFIOQckQ3HQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lpDDWn5Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E16A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 12:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E16A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lpDDWn5Y
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bb5afa736so215434eec.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 04:30:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794054652; cv=none;
        d=google.com; s=arc-20260327;
        b=LaUyaPMcGi3AeeepgVU+1eOiUOgCQ1/HA5xCiWVkdqgcS8QeumHaD/A+nPuCMISIh3
         q0j0sC9YhNlNxsMTXhDbWJ7+0bJj3lsB3PvbNMkEoj3xBiJguVL4jFGpW6aPWT6XjAdW
         DWWWA/mZnyPkJZX/az3Ahm+FpLKTYu42mg/MD4LD4f0nrqqFNC8CK9+p0DuDnnIIfc5d
         Lg1tLCY3v2LB6JgNNnumVW64muAGh8fjOn3Y9rivAdtwR05jXV/bWR0vzEj4Ni/JM7Z0
         RxeyVj+0zpa5qeqmCV9WGz6jEWmJgzQjQw1J4W3+1/5FnUePFNa5RlcCpJMB/6SGwBkn
         rMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tkP1cDv9Adap7kp7q6vc7WrwggtMzAS7jwFRNTqiTKs=;
        fh=iO5m5DdgUXTJvrj89UBUh3cWcCo7AqQydA5lK0GnNdU=;
        b=M5Ul5zyNwVztGJQwOTKbWS8K2Xbx8VDLNbEidyRtPx81G1V1b9a7cO9reQa+oxXlJr
         mzYlKqyYoMr/kVmIF4Swu2Z5tyYcNczu7CxwtjF0PJuoxWJDRgY1bHjg/9gOMROqPmkN
         UH3gtUIRwGAE3dOiHGpqH1OkZaWPTmNjl4yCCW8x2kWGHRXs3zDiG6rtuRMZULkod5sQ
         3bgPFDDUdxBTw3TaUEFnbJGh8rPCtRKN8WnlDTjiNcl5ctkhCzcH5Ex/O8JmmaJikH1u
         swLZCBLe1FfRp7JQqY5VJ6AMKJwPCLothlgjzZsqrlSGgLt/JVN4qsUkIi+MbN2HCt3K
         rsNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794054652; x=1794659452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tkP1cDv9Adap7kp7q6vc7WrwggtMzAS7jwFRNTqiTKs=;
        b=lpDDWn5YVAL4vfoRZ/oqFGpxA+R8qt02m7RQj+hp2Oo+cxokCo5SjeWCvORXPYgkIp
         45We+Cn6PYcp29X55t16+en0Vc1QjobBtRJ9kIIAu3y8KZvR/FQoIJ5xBGIypFfyGt+8
         gPk3xI1caUCHKp4hQsXGCw+ZIk/dF9eG7IopGLbNT3zvs+h0IO1lf59NDz/mHsYt3bHq
         8FTwBaMd5Xu+95ZqE3FJWCeHP+wpy2BcwjzBqipdKCugiprcukm+5OYdAluLhI2QM6sl
         f+w9QKW/YBflOkgSlGFmp+sMfkYFCRaCsIUYCheENOoDvbkauFUzPTEmbS88M8O10l43
         rwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794054652; x=1794659452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tkP1cDv9Adap7kp7q6vc7WrwggtMzAS7jwFRNTqiTKs=;
        b=W6jl8QlUrjaX3Re9hVyEbU86tmLoGWHGWY6RJUl0JIznd2cYN981Hz2v7BL3NLGUWZ
         1NJcCxJXTXi7fU3d7HF/z4j9MvB9ElI58XSZyX73Dk47uaIHJx9UfcryyB6a68w+G2t4
         Vt9rfxtjRcnAQ4atx7pgV3XkSUc4uS2Z/R3IbBF9Kb77TlDwLQwh2OENh8Xhfh461RZ7
         dNMIzjseBxbRwdtKlJztma3tkcIb3+RaYkAkQacocuW0ui1GClkFfo+CZIalJ/g6IKnX
         mGde9b9ew3S8hmV1HXbzOZjMej8WYCS4+D6K5MUozOdj/7OIRlJmdL3Ghjs5hd6UTc06
         5JKg==
X-Forwarded-Encrypted: i=1; AL+hErEft1VOw0CzAbHRz9AGLv8C4/xAtKd+RAg+VSlkvxECr+HQDkCSipAJo99VliXIHxGWTFeNfgY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zw/+U9jrdI9RsCKVlRTlMsTKWUIUYjhsWaFP8UxZQzfCpVFnV
	te8Axocs3nMhFVnGsPLodZM1Rw3EO2HHkPo+EygjYHGazGs+7A0tiJ4SmFDhjuiaoqpeDGeG84B
	AqtS6qPyboFdibZbxPScqY0M4H3wHsVY=
X-Gm-Gg: AYBFou3CEzK2bxQUvHeeHY2tDuwBGB4HoVQe/h2IscTULCcXvI+mI6Ip3xLRf9wedv5
	IQvEvD6t0LX8iUjxsrgmcEHydFzQgoo+0/hJWmV7R+J+DLeM0theQod7nbhE78Gf3un2wb13iYP
	NbSeh1xQHM7ekkE/U+BbwIqOKWsEh9zvEFBbiqV38oEtqJ8gXe3BWKD0rMGiW0hqrG5iA9LRgIF
	4+4Ny/VWrHpixXWCWUzLPgMvwm1K+Ad5rQMvCeOOGTzEOg2bSkRbYhydfRbiDuDyE1usXNSQDnu
	A6ZydTz8WZJdERou+P3Qu5EhAccKGIsQtkpjICoFEagdUDLvRpmqo8QordBg69GVMsUqFFUFynQ
	6ziClTDVLL5EEIW+dg1TnQJ+Xb/hnqKckJ6+JIA+tk2MqpcWnXvMfp4PpoHkMD4EUTAFy2GXwJG
	VTJ/YxZJVvkPunZopnOe4ZU3qV8WaFFULBeN7i2MsWyvHG9FdwGdjjCNEZBwv93czEbTKEKMnZD
	tcC4SP/h3bPxxzdAUkf4FPbtIL9w3+8AJ7i
X-Received: by 2002:a05:693c:3f02:b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-36f7700accamr11167120eec.2.1794054651911; Sat, 07 Nov 2026
 04:30:51 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107053746-failed-6.6-6b704ec9007a@kernel.org>
In-Reply-To: <20261107053746-failed-6.6-6b704ec9007a@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 7 Nov 2026 13:30:38 +0100
X-Gm-Features: AclHuK90kfGTtjGzpa40ZpxOPxV-1JkQzrntbafPkmYypyP2JWJsWm-SxL_xZAY
Message-ID: <CANiq72kpKtjzF+2fuDsLrgfy85UEkb3qA93wURAqYW7gYMbXXA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn` Rust
 function for Rust 1.101.0" failed to apply to 6.6-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: ojeda@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 11:37=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).

6.6 has Rust, but the version is pinned, thus it will not need these
(if we were to change that, we would need to backport others anyway).

Cheers,
Miguel
