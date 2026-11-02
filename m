Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612577;
	b=VhdGSZth7XciKVfHPt5XriNn0mQ2+J6He6XEdEQM/fPlNlj0Pq/C/BYoLsqokuP1nkNv
	 Pmqkd0Wn0of4dr+OLrDusrsBbolUh8g52GJ+p/ltJ5oz+U6/AIR2Qmi2u0ON15hMLXK/6
	 EezMx0kdwMLiI+wz5nfIUDz7x6N9cnXycE81vm9wQSiYkDRNzfQ6DsKSx4i3ICxMgmWy/
	 LW6/pb7YsIC2W+YVmTSTmVYSZaM0HTiz4TBjM0r2+RTcmZz83C7RCbz/BhZpsHn5+tO1a
	 my5NOrTbHHknuf88f25tkC+Tm+Wv2aNactrdlDNshM1VmqEi1jkqRVIbWuxtAWD3Szw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612577;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=s7UqG3TpVMZULsSsKNu6N4cz1DW5BOeuUtIPS6QDAis=;
	b=WAOIXXHLffp1BX/FN01XF5NkDRGkKjEdCUGKrbvrkkjiD4TzkoJi2HzZxDw9TZjoRe5g
	 1B6KhMbAALmmcvIzXQ/b/06R04YDjrgTq06azBKwcarEJpRXUyyPxWSMR00e6Hnh7FqQE
	 NjdArcku3XrMw3tQbYf17xufKcOYfWa/EROzP+Dl45bZe+QAqaOCTdDmhXR7kxs7TdSwN
	 BYd+xulRqI3ZyJjrsxg+xhSEkuQn3Pa7pnhBXu0KUezA5qHOByHuahm0ihDPeVWyeeIsD
	 R8wKf2ft4VyB455cJTnZBi/iLVBoKqvcVWvmALAj8Xb5bm/zuNr13dubEAT2n3xeLFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClPA+bY0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F8606A327;
	Mon,  2 Nov 2026 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClPA+bY0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC901F000C1;
	Mon,  2 Nov 2026 09:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793612576;
	bh=s7UqG3TpVMZULsSsKNu6N4cz1DW5BOeuUtIPS6QDAis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ClPA+bY0o9FxQCw3epZF0M2lsgcTlSM1NNFz9qB/JW0tgE/R64AjRSGxWkn0dGiUB
	 0NacSapE7jKS4ww2wO8aEblAEyUyy3PkCAoFT4p8VChO++7sDabB5gPyV9SjchNBXZ
	 u3cpKD1g/qvToBBSPoC3L4li6QA/0tftW8R6h6MJKwQt9nJfsu+UapGXCgBQKvKq0M
	 oZrUG2OQirut2iIcoDa+/a0yb/GG6PPPdjkqXtJ/6zPNdQRCGUdVzJC1/5gT8FtOz1
	 E79LCOcJHyEmih5hWNJPqGcYdY7QmJnyKAw9Jqfw8J+wCIvXORORsb8hf1uu/DEImN
	 cJ2wfOvNEgXvw==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.ams.internal (Postfix) with ESMTP id B5D5F198004A;
	Mon,  2 Nov 2026 04:42:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 02 Nov 2026 04:42:54 -0500
X-ME-Sender: <xms:G1voajdT0_ST4aQr5srb36ML8tbnQydvXNDb1Wa0pglc3-bl__0YRw>
    <xme:G1voamoeTNZ_tLBRDKp4twtHfohRjjLY4Xdgxca7BPM58xswyriI0uPrLDxUcPrGJ
    Ezolv1sTUcr7-5o0NIrPwaOZweizPE15Oa4Gu575E_BOCfeZSmZZDJm>
X-ME-Received: <xmr:G1voasfqxLXbh9XEw9fIfqRJKKZl5m2OFKwZnoCvtkwLsethhHA1tzFqAMI>
X-ME-Proxy-Cause: dmFkZTGUOybRtx7YsTcBd5eNLK4m3Fkm/Ey/0xNm/0ciR+HWLydMlnFcbPmj41D+Y1M07r
    Sge36pJQ3Qh+uHPDZOt/Z0sw/zsNNy1zqLH6KQvtPBB7yRjuoI07tRUvZSKeBRtG7B1sD0
    uAMxb5LPpw1ft4DgUZO3C8U4DLm5LSGomrKiANeik8BfMUm7H1eDcnAULVGAG4HLh4jZMz
    ngg87BfUvwo2om0W0IDhfELBej4BrrIUZDHHWL61OWFhiKNr8MV2yCZ9saruXg5vczc+sN
    56+11nmDJ3E6+gjErvQq7eGSpVe+dO5PhqG3Qe7j+bLHcDRWh4Xh7mITAz11RYl23v9FNE
    9WySUbJ+jWj8Ngudc6sIePDxuGI+T/pG7YC5TIoUgGstZcw1h8NKcrBTIvaG3VWxSW1vmw
    fgHGNcQRfeqJVryEov4ON6A5qd73Jtl3FkZhFcF8E0cJSOOaXI9bg8it/xzDBUw9aSRrWv
    OnaDSuZ4s2b7vbpy8V2NHpB0dML1teWBFvRl5gk63Z8q8FbTPFM2KWPijasMF0zidFe8bK
    08j54SKtHXyfp4NXSnpoIp949Lvt1fzxEg4CxmQCL/Z0ChfLObP0gnAmQqc8O3pdmwrrKZ
    r+seW0vgXh4jOQejglUudMHx7CMpM2RrChQF3ctdHz/9mo0qPfwkJ8aIjPFA
X-ME-Proxy: <xmx:G1voamlZf7s0DTyUWpxwvlxGs6f2Q_7BgepitSo_USDSMTdr-ErkkQ>
    <xmx:G1voavu_HeXJX7iywt4AiOTqV54DB5KKlTYfIjCXVCp-mJCzZgf7QQ>
    <xmx:G1voapxx6N7ltWYBSw6C5B7w4IbKrl_5MbI5rXH-QcW7rx_qsUlclA>
    <xmx:G1voaqzwqwzR_zITWWZaT7wJMmOSAzFgKSFAW3C2pdC4o69fl8QrtA>
    <xmx:HFvoan5gDyq0b69Nhm1DONlarQjnMvSSx45oTUCz0rkzanScX9i30Ews>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:42:51 -0500 (EST)
Date: Mon, 2 Nov 2026 09:42:50 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Challvy Tee <challvy.tee@gmail.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, dave.hansen@linux.intel.com, rick.p.edgecombe@intel.com, 
	vishal.l.verma@intel.com, kai.huang@intel.com, seanjc@google.com
Subject: Re: [PATCH v4] x86/virt/tdx: Skip TDH.SYS.DISABLE if the TDX module
 is not initialized
Message-ID: <auhbCeeG-hX6tLZ_@thinkstation>
References: <07cfa95a-e766-411b-8765-33352a04c0be@intel.com>
 <20261102073244.919864-1-challvy.tee@gmail.com>
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
In-Reply-To: <20261102073244.919864-1-challvy.tee@gmail.com>

On Mon, Nov 02, 2026 at 03:32:44PM +0800, Challvy Tee wrote:
> Commit 5b25f249be32 ("x86/tdx: Disable the TDX module during kexec and
> kdump") made native_machine_crash_shutdown() call tdx_sys_disable(),
> whose only gate is compile time (CONFIG_INTEL_TDX_HOST).  A kernel that
> never initialized the TDX module therefore still issues
> TDH.SYS.DISABLE.
> 
> In VMX non-root operation on a SEAM-capable host, SEAMCALL causes a VM
> exit instead of a native #UD.  KVM injects #UD only since
> commit 9d7dfb95da2c ("KVM: VMX: Inject #UD if guest tries to execute
> SEAMCALL or TDCALL"), first released in v6.18.  On an older host the
> VMM gets KVM_EXIT_INTERNAL_ERROR and the vCPU never resumes, so
> machine_kexec() is never reached and no vmcore is written.  Kdump is
> thus broken only in guests on SEAM-capable hosts whose hypervisor does
> not handle the exit; plain kexec is unaffected because tdx_shutdown()
> only runs as a syscore op, registered after init_tdx_module() succeeds.
> 
> Gate the SEAMCALL on X86_FEATURE_TDX_HOST_PLATFORM before issuing it,
> the way paddr_is_tdx_private() already guards its own SEAMCALL in this
> file.  Without that feature the module is never initialized, so there
> is nothing to disable; on a TDX host the gate is a no-op.
> 
> It also decouples kdump from the host KVM version -- a guest cannot
> require its host to inject the #UD.
> 
> Fixes: 5b25f249be32 ("x86/tdx: Disable the TDX module during kexec and kdump")
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Challvy Tee <challvy.tee@gmail.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
