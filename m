Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A183955CC
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785661695; cv=none; b=YQLPyTq+kbuCzqPM6m6Im+2xFpC7wW8HgLDqKGBNmwDgX0RXphcmp6phbOtk7lMNDTfrJgtpI1LBxWyR1GQ6uZ0KtrCFAw6KnapxmlypKY63O7Mef12lQVD4efwaitl9N5xMBFvB/SaLyN+qeC+LHCfL4416FObvb8cFPDuCTso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785661695; c=relaxed/simple;
	bh=xAc3AYDOGyP9QxWfF+Uohg2xzlfIy1j62fH2X9YPskw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoxgK7w+PO4jgMOOk+37XiCFzpCxBclfd2C4HrzdpnXuqH/HfPT/jx9rr7GRfcn1zI4dAQUxXXA24cCCA9KuBy9BfqXkVYTSWnB45vFqXjiaT9RVIXQZVxOK/+D43sKU1i9vroiW8sa0vTqNFy4xuPreI3m83isHkIxVxG3icRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alFp81xD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alFp81xD"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-476a130c138so2719119f8f.0
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 02:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785661690; x=1786266490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YjebyDMyP9Ji9siqET61DaxUgJsiKajqLuTyY0HYoJo=;
        b=alFp81xDRIjrKkc0cN3kgAiyXyx3ur0wpd7GoaQ1QQwmFGG5uH5VqBI2dtkP++SQcd
         DmxXCvJ+XeM5fGEIX6pOkJ8EPd1eGM463qfECVgH1svFw/UxzCNPVv0G+X7/eg/1yXRF
         +sN+f8Yelk3RnQ0x85UolcRpqLJHNCvrdJncOqxGZ3gC2zNJ25YR2OhgjfRaJ2w1ipnr
         MTn4/KVj9whQXo18DYakrGXx1uwSQ9MvvfnPGBdWwXFfAbfu8Z5uLX0frso0/Tz0SWsl
         rsBt29A/siIHqZVmfi2bgM8WHHVSUXXGqvfuubD0DjZXTyj96m/Zi7HLB8s0iaIpFk0f
         pHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785661690; x=1786266490;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YjebyDMyP9Ji9siqET61DaxUgJsiKajqLuTyY0HYoJo=;
        b=DTz+ROQvgocen8q+60c9X9tN7FPeBBWz9YoFZ/Etw6dS6/K3lUpFSdqL+4609i5W6h
         PjH40BMkApqVsIYgm8E4b9vvbh7mjFyb7zgUK4AoL2bupMME733VXejnBuqdwVGBCSFw
         V5LH2qdyA0PDmRp/Y71nyHb57gF3VB5YgAYl0yz+ILUtElaY1v+hAuixTf5AWuXsHS3L
         wX8LNYwFVVERIuo9wLwUDbdgcoTTbq3xfZEAa6JbFdGPyHGeBTb7ZH1nbW22ilTtjy2n
         Z8cM8SNls2+KO/PhbC7MwgP/gifTzjXj4Fe2d6SZZT7HI49TpnNzTtOWbfW9F+Vijekw
         6aUw==
X-Forwarded-Encrypted: i=1; AHgh+RoMY+vI7C32rNDv5AvorFlSeLJtlSziXLuYnH8K4GwWeea6KyoCw9aqEig+9LJ9Le+OW3lkqxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMG8DwS3nL/5VJwZnpvV/VFCt4lbQ4qQoP5H+WDdWzcSVD3zE7
	tsuME8uQm5rkKVLDhQF2iJfR9NjPcJQEvGeqgOeuM1FFtKKyRyCf/nlD
X-Gm-Gg: AR+sD1188adLvr9BP5M5FR7OOg0Nf1C0LrFOT3GE5PRgLd5DiMmq0LGG7aK6vj7nQLu
	CUL0cOPGx4hmNlnO84rZ0MRbsMwdusE1qfyRR7RU9GCcLrfqfJv6cmmfl+PRnshBtI5FYQU37bR
	9F6dXXaibmEuBDDyQ13CgtT4VwxY4Ap3S9bvqhuAb/ZyDfk03BX58GAi45yncxXTXla9Ur9IptK
	hRL2gj2/QD7L0F6iOUHWF1ZCOcrzM5RVXl5lDBpKlPX6pYnqA9H+W5XJRQ7kNnW+et27xztdJRb
	eEcIpdVy14qjYiY+q9ismFfbXcKca0vnSoCBEoPD6U8LQskfuC0dgoz9aJkGr2mHB80usj5xnAj
	peD49Ydqq0bbZe0FuUS/R9Kt67xASocAddLp/HgxoY0Xb+nsfkl4aWrNFLC3NA8kx5Rl8ZSTMAq
	WWhyAQLBjgC7vjVJgo3LLDK6qTQpuONbHtHTX8rsUxMSls6sUxh2uoYYv1UcTHgWBsJQhiVRVBy
	1TzZj8jh4l13qvt95Ul0TxqZA==
X-Received: by 2002:a05:6000:2483:b0:47f:7c50:2222 with SMTP id ffacd0b85a97d-47fd72c353emr13580690f8f.24.1785661690303;
        Sun, 02 Aug 2026 02:08:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0ae0sm23010750f8f.33.2026.08.02.02.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 02:08:09 -0700 (PDT)
Date: Sun, 2 Aug 2026 10:08:08 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@kernel.org>,
 <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
 <hpa@zytor.com>, Omar Avelar <omar.avelar@intel.com>,
 <stable@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] x86/build/64: Prevent native builds from generating APX
 instructions
Message-ID: <20260802100808.754400af@pumpkin>
In-Reply-To: <2ea83400-a49e-4015-a0bd-926e5a0ef073@intel.com>
References: <20260708211435.402426-1-chang.seok.bae@intel.com>
	<20260801124429.45d03af7@pumpkin>
	<2ea83400-a49e-4015-a0bd-926e5a0ef073@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Aug 2026 17:00:36 -0700
"Chang S. Bae" <chang.seok.bae@intel.com> wrote:

> On 8/1/2026 4:44 AM, David Laight wrote:
> > 
> > Much like when AVX support was added, -march-native needs to check that the
> > operating system is saving the registers not that the cpu supports them.  
> 
> This GCC bug looks relevant:
> 
>    "__builtin_cpu_supports avx does not verify OS supports it"
>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85100

Yes, except I thought it was much older...

> The resulting commit 059cc8aca774 ("i386: Enable AVX/AVX512 features 
> only if supported by OSXSAVE") switched the compiler to read XCR0 before 
> set_feature().
> 
> Similarly, the APX enablement commit e686416b6217 ("[APX_EGPR] Initial 
> support for APX_F") extends the XCR0 check to determine whether APX is 
> usable. So, the compiler seemingly won't emit APX instructions without 
> OS setting XCR0.APX.

Does that mean that this patch is completely unnecessary?

	David

> 
> Thanks,
> Chang

