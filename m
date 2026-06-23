Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06810208D0
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241742; cv=pass; b=OI4ZPJvUcwCIoXfx+VLUhwljSa9N8uA0UuKGk4gS9p+9pGMD/l9euIL1+zLg3CeGa/Jk1wdMsajq0aNR2RwUrPLhobCjymMlqmI+TPcxrgZouCocHHS0/KTdvl6arLtgRIXi/X1IOaXmPDS2RD91FhokSia9QMEdrFvKkuwCkVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241742; c=relaxed/simple;
	bh=LdofAR8e/Kti/WYvRJh0sJk3FrQJ4xmAUqnttCZI140=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T80krBVM9AwZ8Y77TeoLkiyz84FVG1vQ/y5d712lnd2zKqDFyeETOBpDWVr/GuBmnGhHPrr/oPKcr+wijffxx3ao4dhlklfdBBpa6hNI2k52+kEcGxB4D/QhbDm2wLLd7fKzdTk3WEOUkcRSS1wwVrD8CnUFWcqBXTgs81gBtzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZ4kgKvs; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZ4kgKvs"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c0d6c75c58cso30444066b.1
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 12:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782241739; cv=none;
        d=google.com; s=arc-20240605;
        b=izQDW7APiqEgTuEotDhWSUMbLLRZn2YYQkobPF777IGyyXrm3nKBVwSOjy9Cxi2Pyo
         qvVI6yjhBQW9tgYUZgqnRSRmyLpVd7xsCoo5WivJwwJLP2NqhBPHi/pbuiEXewZ6AeOK
         RuahDhzNMCF0wYI6LxDSvrPAe0tj5QxeWhczbe4X+XrAGE8C3XrJKDl5XZ0YWmnLeCEs
         bWRc6L6qWU563BRiFG6fl8jfZxNLdj0W3e1bVLTO/wuC1XXpfei+qn9hxZcWO9P7btuh
         wg0GmPU2OblexQX5QcMXacUiQM+cu+WlHxfMcwLnwSYDhlHPsRBeEcwangtw7q1/12xl
         7iDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LdofAR8e/Kti/WYvRJh0sJk3FrQJ4xmAUqnttCZI140=;
        fh=ZZMTP/4GG7UK9WEpX+he9ro7gKcWs4NbL8+wT8GHrs4=;
        b=FattRAM2XBAYS02wvxs2AL6xDNqtetx4k2i8fDFI3V+dL8IZL4wVuri0BTcpHFDXb+
         254FfQM/a4vIDvJZGE1lRy4OWY+bJ7vlzKHDlNYAcsmr5KigqnzN/+IyOp8Q0kXd4QVu
         Cs1DouW7l6NYDC2ysVNJUawppihl5x7kqusSsh5Jxc12IJGjBm1zvVqbrAYeouNqxX2w
         8XVF7zE7Zr7oZNb/GOHxVd3yoL7mFJzDLSXnDStKMbW/JErwYHJBHS2hQKXbxLiFoVZe
         QhBT0/Ik2eIvpZ/DukyDg2rRmkBE/t4TMhO7Kh8vG6uPk5g6pFC+KqhlesUVre2Lcouz
         WjiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782241739; x=1782846539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LdofAR8e/Kti/WYvRJh0sJk3FrQJ4xmAUqnttCZI140=;
        b=pZ4kgKvsl8ZfHTMIog2LZaBW7h+HJS3C+m7ai9cn7I9ykrq1XixVJa+svUpkAZe6z0
         6w8Na8Z1HFLbAO7rqFFjKTYugQBoPk3LXkFCNYShEw5QVmcqATfaPzFAjj1vss3wjE6X
         +ENhVhpuv0pcPZUyMoFwGqw2mzujiCWxx/aRYwYqPxi0Nx6xmhOnZPJ6J5uyso92Vq9d
         VTstEXYWkMy9J83N7rxDSDDwsXy1h35SosuiskqCtLAwmdfdaBDVxLoYFaERZ48IxU5L
         0oIdGKVbjD3cBHWuls2UUkpyYuUM/m+FGjU2DWdN9w/DhxDQboLEm8lNwJylxPYLsm5E
         i9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782241739; x=1782846539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdofAR8e/Kti/WYvRJh0sJk3FrQJ4xmAUqnttCZI140=;
        b=anrZ/vRxRYSjL34levqWRRtMKxMieQKZJ3d7mchK107GZlVKuqC8yp1QdLv6rU+8Qm
         lfUMgA9vywiedHzPVxyyprPbuT3Mcyudw/WvMhWpTVPcjnT6z3qH6LtRdSKmVLFuRH2u
         HTpH4O3Ggr0e1MecTqRfXBKAOow16AHqYO+E/B9Rt4zfiZMi0rt6zi4rG3fgQd9Ktbdp
         cu7ir0iY4o2x/T88NmtD/aYJBr9urKNAxygk3SfFxCMlkzNTNhpNZ7ilx1GpURU11Ave
         TxeXGHzzIT/o+pgzbNn5uNAWao53ErmRH9Tlx9h5Guvyh7UXM5E1cjZZBTaXWSNwJcKN
         AhgA==
X-Forwarded-Encrypted: i=1; AFNElJ+SuI/jbjox5pWrA2XhlXcNcKlGK2jZr0mA7nFid+KolK7ivQh39y5vfIUrxU5surmWNMGc3cU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8yJNsWN13S/jTls0lNvTzAw3ZrS4YaZGVi45UiaIcBQQz/i5D
	a1UXd/KGWY+nMVvCmcsh7Mm3kTNmiptwKWHlzQ65yUg0P/J33405AgprwbbVsAmN7XRU43l8uY2
	Txazb149ZnZpXR7tooGcWhe2uFeAYN30CVmvysGk=
X-Gm-Gg: AfdE7clUEzDlsz+y4ob3GLOkSsDiLv3fJV7GfY6OFwWHZAK2L/aE+VPm6tdcCkGzZL1
	AYPK/DFLqWsxTSpRCjBxcPGxrDIXSZWV+Snqanx2aOWuuZnedwlkzRRjHvwt6ULXDsozug6c1rP
	T39XcICVSTDmzZd4y3oh0St+VT2YiQRnpStUT3HfE93ruQZDrT5vyo3infX2QFw1slE7O1CRx8l
	9RYaiRz2zObW/XYHGJwJTmbo+capMd5A5P1WOTNBwvVwSPyGdHr4tj5GDUCo6Qa1OF5bIO+btr6
	ytsXzDJwRCd12+xmJGMOq9Bp8NPCVw==
X-Received: by 2002:a17:907:9c07:b0:c04:93d7:3c12 with SMTP id
 a640c23a62f3a-c0c65adebc1mr95587766b.25.1782241739297; Tue, 23 Jun 2026
 12:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com> <75822857-473d-4067-a378-aae2cdab4176@infradead.org>
In-Reply-To: <75822857-473d-4067-a378-aae2cdab4176@infradead.org>
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
Date: Wed, 24 Jun 2026 00:38:45 +0530
X-Gm-Features: AVVi8Cc1hD2hPk4FFMnKSCHccCyNZqCcEpbtGZZJrz-Ggm9d9Z4FkIbejjM89WE
Message-ID: <CAFgddhKDafzUTCsbYXpWPcN66hetu9aJOygpsb_eLwsU30ADrQ@mail.gmail.com>
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, 
	michal.pecio@gmail.com, stable@vger.kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> add ending '.'
>
> For all lines added here, use tabs instead of spaces for indentation.

Done! Waiting for any other changes before submitting v3
