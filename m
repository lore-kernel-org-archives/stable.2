Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.134.164.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774928;
	b=svS5+HYNdTkXroL07/j4LxqsZ3QC1EkUs0/H/aVP+oI8xbkLKEB6L1j64nVhD4XZYMT2
	 p8Zf4WV8E8LLvCDOZJ5RkKRg6OBlmxYf9hXTDeWViQHBn1tgWG5FnGhxdDRZEz9KZ5EnZ
	 /mQRVONt177fWGW+PbNy8W7PqGjMIur1XTqVUEfWeKthT70+6wR1xKokJCZhasGZnvCUM
	 LPSWbd5i4EN0TqADSwxORqo9LgScdGm1vJnkqNUodmVvwJVlKkAENHadQrgwWbf9BXgMA
	 ZSzH7WI8KVPBARrc0u2emFEiOWxDxa5npo/OPbdYP/HNDG85qHsLo3B468aWwhmAekw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774928;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 Received-SPF:Received-SPF:X-ThreatScanner-Verdict:IronPort-Data:
	 IronPort-HdrOrdr:X-Talos-CUID:X-Talos-MUID:X-IronPort-AV:
	 X-IronPort-Outbreak-Status:X-MGA-submission:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-Mailer:
	 X-Zimbra-Message-Verification:Thread-Topic:Thread-Index;
	bh=NurK4ezqIA5BMNZvLSuYVrqVn3HcqufrAtyykoVqoFg=;
	b=M34SLeZaw9PbcMIHTab3F5wUkSrwkgpn2eJK2nA5WW471BOpo3j2IU6Adbnm+q5iXgD4
	 6erBXm4dFoZ7tWcoWSSFRhBcjZpmp8kMIjvO2mWNn3J2Gz/SwpoaEbOEo1Y50siNR+la3
	 SDZOEZIIhRDCJQkehxNCqtmH5uMHZfJhwPXVxv2OdjpnjvAMHF3WCzn6ASAJbmhkjHDXv
	 4WnYJMIUp44zhEQNJnIhh+W8WuunOIzDP9+TofZw4IBwneMJeKK2N4WF9xXMLnGNTdVlr
	 25BFLOIpymJPWJVlxIusfR8I+p+lZgNmusEzcDN74A8cz8WiqRLbjiW5IofpL6ytc+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inria.fr;
	spf=pass smtp.mailfrom=inria.fr;
	dkim=pass header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b="SQb/luYY";
	arc=none smtp.remote-ip=192.134.164.83
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB172606A324
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB172606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=SQb/luYY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=NurK4ezqIA5BMNZvLSuYVrqVn3HcqufrAtyykoVqoFg=;
  b=SQb/luYY0pPZDVTxSTGdNqm/YSVk8H5vywG5oMalf4Hu9euI3VszTQKW
   A/tTaPNKVe0tMEZfhcOeTQvSxwc8M2ohZGF5v1cQJ3wWL+Trt3a5AvbKq
   9UDUWtIKQIR142/HS2b2kpJDezh9YEXu0kGPIzlvEDGrJKPrzHxoHDXwi
   k=;
X-CSE-ConnectionGUID: J+g7Vi3sTrCv9HUzQfsyZQ==
X-CSE-MsgGUID: u54VmC5gRTuPFSfwE1XCNg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=zakaria.belkadi@inria.fr; spf=None smtp.helo=postmaster@zcs2-store8.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  zakaria.belkadi@inria.fr designates 128.93.142.6 as permitted
  sender) identity=mailfrom; client-ip=128.93.142.6;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="zakaria.belkadi@inria.fr";
  x-sender="zakaria.belkadi@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@zcs2-store8.inria.fr) identity=helo;
  client-ip=128.93.142.6;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="zakaria.belkadi@inria.fr";
  x-sender="postmaster@zcs2-store8.inria.fr";
  x-conformance=spf_only
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:0BBDm6haq6CTHGIdaQLeZGTZX161DRAKZh0ujC45NGQN5FlHY01je
 htvCGDXaK3Za2r8eIoiOYzn9UpQ6MDVy4VjSARl+C1gFykW8JqUDtmncnv9bniYRiHhZBI+v
 p9GMrEsD+htEySC/k/1WlTFhSMhvU1dbuOkUIYoAggoG0k8Dntn0ko58wIAqtYAqcCjBA+Qs
 s/FrcTaOVu0sxZ5KWt8B5ir8XuDh9ys/mlH1rACTaoT5gGHziNKVMt3yZyZdBMUfKEERoZWe
 M6YlNlVzkuBlz8xB9WslKrMc0Fiatb6IQiUh3NKbLOpix5EqzZa+v5T2C00NC+7Ix3Q9zxA4
 I0lWa6YEG/FDYWV8AgpaCS0JgkiVUFw0O+ecCLn6aR/+GWdG5fk660G4EjbpuT08M4vaY1F3
 aVwxDzg8nlvLg95qV62YrAEuygtECXkFKFctS5ezGrCMewNX8Hjfrfz68RJ7g5l06iiHd6GD
 yYYQShkd06FeAFIIFpHTpM4huahwHflG9FagAvP9exmuC6KkFY3jtABM/KNEjCObddcnU+Cp
 2uA9Wn9ARgWNfSezyCE+zSinIcjmAugAN1MS+Dpqq4CbFu72zFPNhg9CFSBneSBpHWwRP8GG
 2cy9X97xUQ13AnxJjXnZDWkvWSfoxodXfJNCfYn7ACLjKzZ/26xBG8DSDdaLtgvtNM3QzEs/
 luImc75Qz1prLCRD3ma89+8rDWuNCxQImESTSsFVhcepdf5rYw/gwnMUtF7VqmvgbXdAi35y
 TSHhDYxiq9VjsMR0ai/u1fdjFqEo5HVUg44+UPIX2ah7wp8Ioe4Y4CA5l3S7PIGJ4GcJnGDt
 X4F3c6f7/0KBLmJlSqQUKMMGq2k47CONzi0qURoE4Mg+DPr5X+9fKhR5i1zIAFiNcNsRNPyS
 F3YolkU/4NUJnb6K65xeYO4TcowpUT9KenYujnvRoImSvBMmMWvpUmCuWb4M6HRfEkQfWUXK
 5yAK4O3EXEABPQhzTysRu5b36VDKuXSA4/MbciT8vhl+eL2iL2ppXMtMV2Ub+l/4rnsTMD97
 YNEL8XTo/lAeLSWXxQ7OrL/4bzHwbbXyHw2RwFqmja/Hzdb
IronPort-HdrOrdr: A9a23:boDHiK+VW83yy+0vtLBuk+D2I+orL9Y04lQ7vn2ZhyY4TiX4ra
 CTdZsgviMc5Ax6ZJhCo7G90cu7Lk80nKQdibX5Vo3NYOCSghrNEGgU1/qE/9SPIUDDH5ZmpM
 Vdmv9Feb7NJGk/vsb/6xKxV/It2sOO/qztuuvEz3hsRwl2a6dmhj0JbzqmLg==
X-Talos-CUID: 9a23:TdAk1m7/g+BPU8UZadss1g0bRf4kKWbh1lzOcm+FG19nU6yncArF
X-Talos-MUID: 9a23:FGFoJwtzhtQj3Juggs2nmWw+CsJDvquUNF01v64IpOTdBQdWNGLI
X-IronPort-AV: E=Sophos;i="6.27,236,1787004000"; 
   d="scan'208";a="307675948"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGSaIjKpjkDMm021PAEHsPTC2TmPdkTx0h02O?=
 =?us-ascii?q?3JSkt1ynYKqOz9awmbwMoR92Qd+AkHladWVMWplmDBqzlj21pt6npWn3?=
 =?us-ascii?q?+Ae5yk2VsOzXAUPEgssENhdtL2O1+mhH7K+QveiSeuppSgtfwoXONdLJ?=
 =?us-ascii?q?SjfAJYDGIVL6LvMe9PNBs4dQ=3D=3D?=
Received: from zcs2-store8.inria.fr ([128.93.142.6])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Nov 2026 11:22:00 +0100
Date: Fri, 27 Nov 2026 11:21:59 +0100 (CET)
From: Zakaria Belkadi <zakaria.belkadi@inria.fr>
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, 
	stable <stable@vger.kernel.org>, 
	Matthew Auld <matthew.william.auld@gmail.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Message-ID: <1885002349.1698785.1795774919927.JavaMail.zimbra@inria.fr>
In-Reply-To: <31feca61-7439-4006-91f3-2dedb3dca27a@ursulin.net>
References: <20261126094444.52858-1-joonas.lahtinen@linux.intel.com> <31feca61-7439-4006-91f3-2dedb3dca27a@ursulin.net>
Subject: Re: [PATCH] drm/i915: Reject relocation writes to RO userptr
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.21_GA_4899 (ZimbraWebClient - FF153 (Linux)/10.1.21_GA_4899)
X-Zimbra-Message-Verification: hash=SHA256;guid=YzZhNWU0NzFhNjI2YjAyZjZkMWNmOGVkZjQ4MzFiMzdmY2RhNGVhM2JmYTRlNzcwMGZmOTI2OWFmMDY2NjFkNA==
Thread-Topic: drm/i915: Reject relocation writes to RO userptr
Thread-Index: /XCWHdHDaXBGJkoVJBUU4SBbdnDnEQ==

Tested-by: Zakaria Belkadi <zakaria.belkadi@inria.fr>
