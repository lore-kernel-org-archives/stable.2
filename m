Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C024E4A1
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810725; cv=none; b=mw8shKnNFDNcI/zjKUAepEF5llff5P5TCaVNBMPAJlsw/JxC4Tepd8+h8TKYCdaiDrkGbWlieCYT2prkZP4M5pORhTqPGvkIk4v1DXFdxMhYSt6nCJxKOZY4aKzELVsktS3G0EB67TiaHmecb8WtUXqQRoOaoUEaf8VVG0ylfJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810725; c=relaxed/simple;
	bh=MJ/atw/sjJbjgNUE/NJPSlbXr6d7eVv74PHfVe2Qqz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfgV1ZriwFKDWkpoN8BJRbBwCKjFateyO+PTw0/c7cvF2WVOfYIsJ6XJcKMt1qBVrcxevNXRMQDTZJbofMUmf74jLJ5yCKMWXM0WqWFNH2aytqhVwA4bKaXYZ6ywYJW6Ses1Cqey3PyGdntgo3NImkpHpUoqY+fS2WP3jwF7TCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E4AU9xGx; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E4AU9xGx"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bec49f7e35eso186554466b.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781810722; x=1782415522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6gl/162Yyv89laBaNydReyy3xdtnaXM6oi2Bko2qKKQ=;
        b=E4AU9xGxnqZai2+JMxBxCKLKGw1fTlbShXmto3YMAJRIrTW1lfXacuH6Y4aZBKqU7V
         5M6guT8XlG8CQoXPPe1gw2BHod+eZxZTdyMD9+rVJYW5HD3WuIoEglCwWExWeKeeED3H
         7wre97/JQEZfmdwxfzFvI0SJ/s37z7gv2S+1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810722; x=1782415522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gl/162Yyv89laBaNydReyy3xdtnaXM6oi2Bko2qKKQ=;
        b=RiAqiFZabdDnSEb7Xgd5YkIQDnqKoNwTeM86u0sDkWH/6V81h2wOV/YX/VpiMiwhMm
         wXZp45uXrIDkPWDQJVOu0mzqI6U4VV7pd+TRhdAcdu7F+XF0/XgwWKIRhjCzstUoZxCH
         Gq+AQDhFLBy4b8hZWFAH62ns9o/0WaW75VsqbXSTiRSQYN5GuZvHwVU1lt3HTsWYsh2P
         k377gigMIEp1hHNQg7kJxu9GTF4QFG2UeeK69Q8X05fQM7q4DeMhBDa6ynXXFi6rXL66
         EFsOvvTxY5kVhxRGSEvfpkHkWZreFL6+tc7dsRj0q5v2JLT7Oq7LFpCWAWUv634/PD8q
         9LMA==
X-Forwarded-Encrypted: i=1; AFNElJ+cZiAHYFeqlromqsANGh+8SRYjSvwZKlDR9r8wZuUW9Emr05Q8NgxnzQDIijQS9FD5T7HpUZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYuwUTwTj2OfbbUaXjdykWiKqAiy+C8wSh86eaCFhZ7NHuNMpN
	1ba/hr/bINUXWIUL5i1yXauxelQ6iuPo7/5cQuLG8JgmS87rFhaKMEzgBlu0d1xZ0cWO/LlbP27
	rlKaoBb8=
X-Gm-Gg: AfdE7clVgVFtqFP2rT7574o1mQPjs1iC5SuTqrLOht6giI4vUVDJSo+gs+8sB9bupGN
	42eVgpILT0FdzDVMJuYFKRXUw2pw44KGFPvP3LwB50Jn85c8j/wFbdp3A6wMjlDie/052Es/aK4
	FZ5JXhXa1Ok3Y0xXa9uanD9ZXVZDCmp0i+vQzaj3zA3wClFxYrsY8oraWoKT6EkecD5LblHkgKV
	YDmxIlImWGDXCmAt4Mj5l6pkYyZxnA9tNzCV6RS8Y7/wwXUAv/TFgYMUqlg07kjnu8gXhYYusP8
	UKLpRITSGII7Qwdt2SivReAb8mwD/BsRDu25AMsv4kph4S87zxZxeRT8GN44BFfwIfUb56YDy5N
	01y8h7AdGd+HhdRMws0SpA9OPIPZB4cLjoMZrGoB0dJvLNql7C4FPdJfgycq2n5jX9nTTUdH19y
	pVEwpLOHbUkMdwBkIjvnWAT1d5dV5GruW0ARXcOeyPk8YkW6W3LvprWam5dt++
X-Received: by 2002:a17:906:6a22:b0:c06:3880:69fb with SMTP id a640c23a62f3a-c097adf68f8mr29155566b.3.1781810722195;
        Thu, 18 Jun 2026 12:25:22 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb511b8aasm990884066b.24.2026.06.18.12.25.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 12:25:21 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bf046d4da1fso147539766b.3
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:25:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/evum7l6FpMtwTPKWk9qpPIJ4VW01j7KKzKbqbOqUun5c2zzB4di2wxNKQssvvZ54EXu2fhOY=@vger.kernel.org
X-Received: by 2002:a17:907:3cc2:b0:bfe:ed06:5a16 with SMTP id
 a640c23a62f3a-c098fed1511mr23022066b.52.1781810719995; Thu, 18 Jun 2026
 12:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618183442.BBCD71F000E9@smtp.kernel.org>
In-Reply-To: <20260618183442.BBCD71F000E9@smtp.kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 18 Jun 2026 12:25:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQ_10MRYYW+aRfLP4Ah9gDrShOvLESXtz+Q32-9M9Y9w@mail.gmail.com>
X-Gm-Features: AVVi8CfH2WnN-uQgGzjlFiJWeaLtj_2exZjAxtndehiWrEVgNpGbugy27v-vnzY
Message-ID: <CAHk-=wiQ_10MRYYW+aRfLP4Ah9gDrShOvLESXtz+Q32-9M9Y9w@mail.gmail.com>
Subject: Re: + userfaultfd-prevent-registration-of-special-vmas.patch added to
 mm-hotfixes-unstable branch
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, vladimirelitokarev@gmail.com, 
	viro@zeniv.linux.org.uk, stable@vger.kernel.org, peterx@redhat.com, 
	oleg@redhat.com, jack@suse.cz, david@kernel.org, brauner@kernel.org, 
	rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jun 2026 at 11:34, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Since VM_SPECIAL includes VM_DONTEXPAND which is set but hugetlb, exclude
> hugetlb VMAs from the check for VM_SPECIAL.

This seems bogus.

If somebody sets DONTEXPAND, then that mapping *is* special, and
userfaultfd should not mess with it.

It feels like hugetlbfs is just wrong to do this.

This has caused problems before, see MADV_DODUMP which has that same
"hugetlb doesn't follow the rules" check.

What exactly is it that hugetlbfs wants that DONTEXPAND thing to be?

That said, I don't like the VM_SPECIAL bit mask all that much, because
it doesn't specify *what* kind of "special" it is.

                  Linus
