Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002458;
	b=wdhCL99jCModg038NteVuicHPgpbCPRxltXBqSEjLgdSAsomyjunBx1NH4DpcfC0PCUI
	 IKxj9fdn+d9cjNEoyI8/dPZGBgjV0+C12v4b2tqkFmj9agn18W6GGCqoJWnICxXW2aHg3
	 qcPOBE3Rc1QA3YnfIMt7wkRbGSnqP6r/NAP5pEEd74sqje+9/N/FYWFhtExq8PJhL/a6D
	 qVO1PNR6ckTtTMrfCMQcbNPNaV7Nj3WlifaxDtoO1UrNhdWSgaoDUtGj62k+x9rgHcAYu
	 B8N9QVUNngNJeKb/ywJ3a3XVzkSqBDNGLEGadUbukuSHX3uH6itNppdABbXepF/z2xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002458;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2/1a+0hfINhT+rFTP4LoNKCrzK1077KyAh+tEOMN0lE=;
	b=dMTAHH8k5u3e5KsHBbwwzyN3D0u306d/WKMRcDZ04lAnfO6hOL8IGe0VfK3WzlvHYbdP
	 beoQkJQHUAcZn+dJgQI/s/ubPSP+O4PdeRbNZIDZz5/6CT7YrrJv6eoIZMhe+UBUqdLkI
	 iznjnGDwYU+83JxMphgN1dg2aLrDozLTzdqNj6+xP9Jh2PI9zprjC+amwfC7wEf1W8+IY
	 bzskf0Tu8TmndM3XlV5C9f488iw6fWeoRuLGAnD/hw7ivsSHzt9qLgb3v3NTxij8Fo/gX
	 8k1SnfZnkZRN0qUqfQS6MHtyKzlLP+GPiCksDOCzX1fdS6jpVHInDQkIbmHVc8nBlYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FKIDnG5w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA4C606A31C;
	Wed, 18 Nov 2026 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FKIDnG5w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADC51F000C4;
	Wed, 18 Nov 2026 11:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795002457;
	bh=2/1a+0hfINhT+rFTP4LoNKCrzK1077KyAh+tEOMN0lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FKIDnG5woqjyOSVggAeHGNAvXuL9AeawvrDj58GwxVHBo4nWdW5Rx3tEA+TyZ1ocx
	 y3W5AbeR8Y6SIaHTT0kXZKAAtZxuGWEkWPTNU1cNcr0gYwrtMRP2lxF61CQwfyZLh7
	 /mBjFVSgDT7ZJEscKhYXen0fEAZM+M7y7vS1Js2k=
Date: Wed, 18 Nov 2026 12:47:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Artem Novikov <naa@amicon.ru>
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
	seanjc@google.com
Subject: Re: [PATCH 5.10 0/5] KVM: x86: Backport shadow MMU GFN and role fixes
Message-ID: <2026111856-snowboard-unknotted-8b75@gregkh>
References: <20261118114226.26178-1-naa@amicon.ru>
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
In-Reply-To: <20261118114226.26178-1-naa@amicon.ru>

On Wed, Nov 18, 2026 at 02:42:21PM +0300, Artem Novikov wrote:
> Backport the shadow MMU fixes for CVE-2026-46113 and CVE-2026-53359
> to linux-5.10.y at 3a323bc22b88 (Linux 5.10.274). A linked child is
> reusable only when its GFN and complete role match the current walk.

Why are you running KVM on 5.10 which is going end-of-life 12 days?

Please don't.

