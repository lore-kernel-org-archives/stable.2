Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820224;
	b=H6cHpvt99v+EHhnSX/mlApkabWtA075FPJKG+pc+WIL/ng4lLah4/zpTLd0MAQGPTZgl
	 ucBr570Mdy7q0ZvrC+oVsCQd0v8oUQTRBrxm663VZuLCR/CaaMbkfHM0lZR8k9vwrUBTD
	 NkTgXZdcWM++5ReyfsAZlZibZ+Wsys6hESbxXi3RoCSW1jUodCtNvU6O/UeiApPcPsaze
	 OhWlKLKhCaGjXyCwWqP7T7oqGcuwZHe0FN381Nuh8ZTKp7JU8ZvumJ5KF/aetU4LJZC/3
	 wValLJtNsncq2qvbGgG+/ydtI3a7QH/YCTkSfnKHTKPQGFDuS+4qwEied4Nvu3dGH2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=46TgEEpU2cLyOA8VrjeroVXP2AzZevlXDET/sZONzQA=;
	b=ieU3HMFOz+T1ky2+6btp+Fs6u5CveDo/2ADchBOghVBVS83CcD6OxvgEQjb99fx8skPP
	 mmUzrbdqe3un1Yhss/HPjqASKpv1T65xUc0BHWtQwsBCmCGaqCVOgo4aRwk0bY38zj243
	 L/cL+w4Iy+EuXHDXSV0neDJH77lHDkFyyWBkw5oWFtC3VK1V0XS5FDTcIRHSxbPjSnGHd
	 iHwY37T90DECp1GW8uuDzDcQcpspybJJqqFmsLsriaDipyAuWqHUvjFs18w6CG/xkZ2my
	 t1HXYFiXiQ2u3Oe2iB4DczOjPu7Lv6t9iDdriNejHzxr98pM/da3hsfIHYeHyBWj3Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="EZLjO5/d";
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE31606D4FC
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE31606D4FC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EZLjO5/d
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so9275ad.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 11:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793820224; x=1794425024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46TgEEpU2cLyOA8VrjeroVXP2AzZevlXDET/sZONzQA=;
        b=EZLjO5/dHhZww1BHBnX4Wc8ofH+0qETmUEMKT1ZmWbRgkbJPb62CYdGFMCH/MUXNWL
         l9MSavtdpo5QPPGVy+0ijqvvbAROu6+NIgD7i8PmUZqVWw7YJD6OI+rGAGvt5jG+DRT6
         tTI3xF+nYr3tXSjQyB9Lp+giNMgxWdqjrbT3tKAaNjm/RPVbDrMsizFEHRBDHWBCxTQ0
         PC8iA+UdadAI+viNpE9x9R9BK4rARxktrG9nA0PN/P5MB4RnSQzEzK83OB2nCAnUGueh
         sJiRRAYCcuCPOiXMR3aK6vrr+k3IL3GBjO/fBxuORJMh9uvD8YK76UAIiHwl/JWVTkBp
         wcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820224; x=1794425024;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46TgEEpU2cLyOA8VrjeroVXP2AzZevlXDET/sZONzQA=;
        b=FD/9h2kY16cjFdp5p9m3jKSUPygHyWglD5PProxByOTD+ZJu4fOZkVNyHv6aODT2kY
         YVjOH00njwLSXuWeRw+xDmlIQiw521HldS92eMvqwcEDaGzSBkW2YHjUCTehIoVz2+Zb
         kt7x30GxiatQlmlezIGk3FRbfJ/L4Zr9wUCePjAHCPMGK/ekk8JMDUO5eD4k7NoPFlpB
         YxvT4wVjl5neTBDweSmlbAxGuSQN9MMuFzi/+8q4qmZ03tdkzpEseCVp0pzDZhWvleAV
         YEbgJndHtxPoaJKbV1tz3gfLc+kYgdyl75gpqHIsV3AIPfgPWn24D4XbVkaI9vr7q3BN
         Fsrw==
X-Forwarded-Encrypted: i=1; AKwUvBwjg8VKMVvTNwTmBlbaND0JVF+5u7f/BVy6h64KdZ4900c6v+XWlV7NvY3agB8V5pLRIlcPuEU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wyWZq+4Hk7xYcjuO+yHnLDtwcjb3t1ZqmA/ZBPMGW4hhCxvGG
	J4NOFvEZreKQZWHWwIkk6LxTA8WdwXsPwGQf/ToLEPvdVnW9UxXHH0AlgBWdzRaIEralNhzRqYT
	ntRsvaA==
X-Gm-Gg: AYBFou2VulpVLQ1DRelvb9WrniO9yH5e9wO7TfsN/I66ZlOeCKXyLtXDX8ibIzarJwV
	BbRRczlS67ikOkSYWhDuTiwSPl8ymTkZPGLz4eRv9SVmj38MT/G7PHrqhkFiHdWM17M/kyP4dGY
	bSCd62CHTKfOjCewAdXasPmKnGluebvNA7t7Zr0Yd3wIobBsQPhUfBLe3iH7UF5/SIMF3wnvzfW
	zQUKquWWwRFGe+r7LH7Bsen2U+Dj7YEalYK3qtpwavFJYlbYcteXhvmMsSriSiPwztVQagLARbJ
	c0E/lirqJOvmeiHtZ7D7DSsrE6Eg1LBi/HwlPE4Y8CEgAsXGO9Cfnmg/8dwpOHNn8yKlIwl6WzR
	OPutPj8B32xwnfJ7+poOrLNzcw0f/v+DTuesJvuurpA3YzTcnkk1rO+TddFQG1U1xvldBqgrRBH
	oexC0Ynt2vPZIYsaO80v2GxuSD7uAXqMLrk6B27JDYq3t5vwgK8vTQ7ZlNRCLx/rPGT8pymLCeX
	E0jl/xwU/BPK0tqLS7KOMSrugtMnaVrhr6L8p6C1nTmRGsPDXw/WYrnl1J1XwOVxCvan4XM0A7s
	UvK3P4H6qk8LFCESz57EelGUE6TedmK0ADEj4YUbTuAgBkJyUB3lGLvqZkeBcgemR1gMtYzWIa/
	aYkt4VFpCtedcXVIhBq2dia7o83vfmbQL48QqO4TeOxfqP4pdgnaztEXhrD6Dukh0DWYqbi9BNz
	A1CONO0CYxlic+sCSYmDF9xqigh0gV652hq0s2jRT53MT7zzXVluZGFLCJF1/GXA==
X-Received: by 2002:a17:902:cecf:b0:2e6:f400:5655 with SMTP id d9443c01a7336-2ed2613a591mr493935ad.3.1793820223025;
        Wed, 04 Nov 2026 11:23:43 -0800 (PST)
Received: from google.com (20.131.16.34.bc.googleusercontent.com. [34.16.131.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09b6634cesm1282834b3a.39.2026.11.04.11.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:23:42 -0800 (PST)
Date: Wed, 4 Nov 2026 19:23:38 +0000
From: Carlos Llamas <cmllamas@google.com>
To: gregkh@linuxfoundation.org
Cc: aliceryhl@google.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] rust_binderfs: add transaction_report
 feature entry" failed to apply to 7.3-stable tree
Message-ID: <auuGOvKNKpJ1saa0@google.com>
References: <2026110401-lure-unmoving-2038@gregkh>
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
In-Reply-To: <2026110401-lure-unmoving-2038@gregkh>

On Wed, Nov 04, 2026 at 03:12:01PM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 7.3-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
> git checkout FETCH_HEAD
> git cherry-pick -x 2fcc8b9687af998b74ce6b0d349167eae7931558
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110401-lure-unmoving-2038@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 2fcc8b9687af998b74ce6b0d349167eae7931558 Mon Sep 17 00:00:00 2001
> From: Carlos Llamas <cmllamas@google.com>
> Date: Wed, 16 Sep 2026 12:08:32 +0000
> Subject: [PATCH] rust_binderfs: add transaction_report feature entry
> 
> rust_binderfs is missing the equivalent of commit f37b55ded8ed ("binder:
> add transaction_report feature entry"), which adds "transaction_report"
> to the binderfs feature list. This helps userspace determine if the
> BINDER_CMD_REPORT from the generic netlink API is supported.
> 
> Cc: stable@vger.kernel.org
> Fixes: f14e0c8183bc ("rust_binder: report netlink transactions")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://patch.msgid.link/20260916120833.593407-1-cmllamas@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This might have been my fault because I added the Cc: stable tag.
However, no backport is needed. The patch is already applied to the 7.3
tree as commit 137d6ccf0ec8 ("rust_binderfs: add transaction_report
feature entry").

--
Carlos Llamas
