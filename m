Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9D30F7EB;
	Fri, 28 Aug 2026 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926645; cv=none; b=FBnkJ0DcQGYJxLteQiY56RSjHpuJOWVxZfF889tEw7zVz0+ip1YfbpIj9eq+i37cujqBg7jv9jmmVMRpuLEU+6mOF83K0E2a1bsG045BwmvGX3oQI04fDSu9GBUW4TB3s4vwjsxctQd+hqx3fqRQ4OeaYZm1HWTbKlstyDeuWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926645; c=relaxed/simple;
	bh=Ih2dmJ5lzPl5QMQGbFCQ7a0yL50W+Kc7BUwnje3ppkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXZEgicgw7bq2lDSU6WIGPR7nsUXQ5+EiMFS3GpG/cNaL3Or5I8alUg+g4OCvjhvpRJzQF8d6EplZ5DZJ3+v7RcZ8M25lVOUHbbb4LGmJogoeifcmrKttx3p4BUD9/D/o2zwO97L3iw+xBWiB9iyhFlVRSG2V3QWZO9mfyvLWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=iEtTRLjL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="iEtTRLjL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RbCDDoVeBxlRx6HSyQuSlbHEivxBWQB6WL29vZKcHcE=; b=iEtTRLjLG5nsn8nxwskhv4eH+l
	FqwYItiaB/av6OxrXi32l2iDxtKoA0Ghl7UKzjXAYxGQ3dGZZhUBveAxDQ7dNw0BwdVzvvUVO0sxU
	47k2jvvxnCXL/mZjNw+yhY5B1bIRRX4kWDFZTLLfQ8AyyE96+8Ix9oUhMiqnaWjEkdyit3oAY0xZ3
	4B+LML5lamZpMiaNTXPCdQU18TgB6+yZ10sAt6Ram0rWqLjj0LOUsmczg3JR8uUyi7LsoASWmDZHi
	91Ixa6kMKLVvw+NACI5dB+NlGfH2BPqYrBx1vEjYHzLfpFX0iLW/Qsus6fW2dvrjJ/t+oLGz3h/Ya
	BR7UJMKw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wzxOM-00Gpb7-0q;
	Fri, 28 Aug 2026 14:17:14 +0000
Date: Fri, 28 Aug 2026 07:17:07 -0700
From: Breno Leitao <leitao@debian.org>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: AutonomousCodeSecurity@microsoft.com, andriin@fb.com, ast@kernel.org, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kafai@fb.com, kuba@kernel.org, kuniyu@google.com, 
	kys@microsoft.com, linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matttbe@kernel.org, mptcp@lists.linux.dev, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	tgopinath@linux.microsoft.com, xmei5@asu.edu, yhs@fb.com
Subject: Re: [PATCH net v3 1/2] tcp: fix use-after-free in
 do_tcp_getsockopt(TCP_CONGESTION)
Message-ID: <apGQkAXE7ZkLkqBi@gmail.com>
References: <apGBE3XHKeNohHF1@gmail.com>
 <20260828130212.32968-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828130212.32968-1-blbllhy@gmail.com>
X-Debian-User: leitao

On Fri, Aug 28, 2026 at 09:02:12AM -0400, Cen Zhang (Microsoft) wrote:
> > nit: Do you need to zero this string? It will be safely overwritten
> > below, no?
> 
> Thanks for catching this. That initialization is unnecessary. Would
> you prefer a new version for this, or are you okay with keeping it
> as-is? I may need a few days before I can send a new version due to an
> ongoing email account approval process.

Right, this is just a nit, as I noted above.

We could leave it for the netdev maintainers to flag, but given how
strict netdev's review process is, I wouldn't be surprised if they
still ask for it to be cleaned up.
