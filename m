Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41148A2C3
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288383; cv=none; b=qQhH78hPqyGstwToednAo2HLrjGKazN3oqxKUCw1mfpEZUM8ngiJ3dUC6plRCHD9I8RRw+vhP/meftS1MtBW5Gw5061ix/ydg7tUnEzEWTWX25ZDHtV6N1UP5+ikjklrF+nryS+H3XCL9IiVBVY6Q0pg/rAoIhPLAAEgOobSQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288383; c=relaxed/simple;
	bh=fQjGHe34GiV6VnKplf5aUBrhCsRxjFQNs9KJ4DJ16HQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XlADf7goWLoKpt+JEOIVUuulmzZS2JorovaH1QPoNXqDt96qnCoSUdndDTwZP9byb4reGZdoNjvPKgr3Q1+Dt+1s2SMgyPcljWpq7mWTZKpKl2SzlGpBXQz4yM2aC5H0ytUopiZZbBPk8YuHeTqMo47ODF3YKNvqKUXtJhSiTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDBZmDDj; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDBZmDDj"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d94a158dc8so1800405ad.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788288381; x=1788893181; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYbovvi4CtGez0U+CPTTY7K/JumHW6fBnAFDxVdakA8=;
        b=CDBZmDDjzEJSv3Wo2zFsxjE4QJ2agenmcwu7ReLFOj2HCUmVGndJSmP0D+JRU/HXyv
         CgG9drUBZg5I6aJl5ep8Xy86M5lbJEz7yEWnmKzbjYLDdYtAUhm0CoCK7FCa1ckEuQrs
         ZrowDAh2eB4w0lY6yXLuJGWeW23A1YB23M0P21gRv0rbn6N+aGJZGuqVK+ivDCriVkpf
         aFbOHHxXGVdYECy+/71ZOYKy6CjOgNFC08TwqyEvJ8B0suWnp6hBIcHK17pE8eYYuBus
         8YkWoh7o2IpFlOjJnVmumtwuwFWrekcn0r7xXuxmtUff+WVMF0egPqJaR+D+dHI31uXg
         p3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788288381; x=1788893181;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JYbovvi4CtGez0U+CPTTY7K/JumHW6fBnAFDxVdakA8=;
        b=OWlAlfa8s9e9C4mH2d6sKV6aaK9To8rDcseSIGqnCnS43Zul55iQcqBE+lnBBnrpzN
         wZbutJnCdVox8DqztWisj7IqsS6GtGeW07fJe2tPDeceIAJOArxRrA/3JvTV8lDYtVKP
         EO9nv1uw4pxX8kKBQjRD20H0djrtC6LSwKg16VFSdNyY/B3QxuaoZYorlPiLsi9gwwdT
         t/tOg8BFdwcXvwCccJHeKqGzSiACDt7P7etJcvf94/D7TCvUVsOOky3ZEDWDWA6qfUzs
         nXUoXtzwVYKsVsy4n2Bf5lxDLn+xEy0loU5bDvqqY9rb9l/Mjc0nPHzO76pLP9MW/hYP
         GY1g==
X-Gm-Message-State: AFuF++nR4y62aZVzGzPFLXO3k11Tkf2XymMHZdx067p0NCDpE8NroJJ0
	0TIwvPzbK2P2+C/5tGE5yuNhXrKWjqJMB5JwrZlDLiP17hhpYFj+zkBB3+DoL8I+TjurI6vbpTK
	osagOZA==
X-Received: from plbkq7.prod.google.com ([2002:a17:903:2847:b0:2c7:ec09:a994])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:15c7:b0:2d8:d4ce:7e3d
 with SMTP id d9443c01a7336-2dae5edf6e4mr4326065ad.18.1788288381336; Tue, 01
 Sep 2026 11:46:21 -0700 (PDT)
Date: Tue, 1 Sep 2026 11:46:20 -0700
In-Reply-To: <20260831210958.1798565-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026083147-overrate-roster-23cf@gregkh> <20260831210958.1798565-1-sashal@kernel.org>
Message-ID: <apcdfJ7XdaATHSXD@google.com>
Subject: Re: [PATCH 6.12.y] KVM: SEV: Wire up kvm_x86_ops.gmem_xxx() if and
 only if CONFIG_KVM_AMD_SEV=y
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 31, 2026, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 01a96ff30dde5127c37497f1e098e639e7ae152f ]
> 
> Wire up the SEV-SNP guest_memfd kvm_x86_ops hooks if and only if SEV is
> actually enabled, and drop the now-unnecessary stubs.  Leaving the hooks
> NULL allows the static call infrastructure to elide the CALL+RET, and more
> importantly, referencing the hooks if and only if SEV support is enabled
> will allow conditionally definining the hooks using their corresponding
> HAVE_KVM_ARCH_GMEM_XXX Kconfig.
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org # 6.12.x
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> Link: https://patch.msgid.link/20260709204948.1988414-5-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ adapted gmem_max_mapping_level hook to the older private_max_mapping_level API ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
