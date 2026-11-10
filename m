Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329567;
	b=ulGNfSsQnzCwMxu2A7przdWV9F0URqgvJ6Ol0sZjkPVyg/mjgKrydcOb5sKbB1zUcBD6
	 z75QSHbNS91gksYNTh4P2lSsI+Oz07ygXR/qZvZPvklf3JWBBg4iCoJ5gHZKFqpDROesJ
	 bPerJCklZtfIuIprQqR3mKTNV5cW9nSHICcctgQpqYY8xK6AN16ISprHzlNShr5a67UPu
	 XQ0Q7WdrMo5b0fM1plRB+FdYloSgv2sOAxPBOe/nXQ1Q7mdQFJ1jbHwe3SyGDPYFgqSUu
	 KX+nHx8Pueio0HS/LTP/WhvrFPEpYV76XY/jacAzQH4DlyN6QFZaLpfkJjLCH5Iuh7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329567;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=73EB4AvVq0oZ3UvAs/LOaer8lWZsO6R1BH9jbjOLBYM=;
	b=tCIz0IxJD7AkTfZrCRfV4iUnYnlmMZf5vWSuKkKMuitTIwg7+meBWSIRfexoeBfyEUkp
	 9K6HLwHawbmq9WOwvKROM93L2kDaYV1Lb3sbCCrVRDzLO/EeTK43uQUn6Wt5FXa7mwINg
	 cliNm24CADoRzdAzd2I0Pb/5fpyEjPSwWEnL2+c0vutV7t02F9aj460fwNzdj9r474OYV
	 DXpCfaviBC6mBlI2W3/JbEKVxg6Ex2s3m+p5FE2EPvrlVIEV7l4sJctDK2H6b5PLqtSmY
	 pvR6+n0KxsQi+iGIF/BpJQUfAEtflonmw8VrbXGTW3VJWS46AbmJP6snz1fMzmWwkEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b="Lqb/W/g7";
	arc=none smtp.remote-ip=209.85.160.230
Received: from mail-qt1-f230.google.com (mail-qt1-f230.google.com [209.85.160.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F4360A2638
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7F4360A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=Lqb/W/g7
Received: by mail-qt1-f230.google.com with SMTP id d75a77b69052e-53653e30353so29320211cf.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329566; x=1794934366;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=73EB4AvVq0oZ3UvAs/LOaer8lWZsO6R1BH9jbjOLBYM=;
        b=naJhiGLEpnmCbH3jK8UYmO1PqN8Id/KjlW28OioUUKBES4QBblsHAryH61R9Xa2nQA
         pskbKHCAh01zmgn83NDN8otBnhDKdsG1EQPwzm8O8MKO2qo/kOH784AsnYkv/tvufyoI
         CiAjO88CbZcdE1Ell/YcqyIdx8g9dynuNIax6kxaCeMTkFV4gqRhsnTf1Hl8673/SUTy
         S/lJovHGK4zKsgePF7OVY4lt4VQrfZBjpjoBTrPb/BYqMmlPEHyLFiPVFhpHNt5LzYvE
         OY5SKoVvTmLEUOni5H179hFaferI5UQlLEPCcneyeXEITUJEw/RQvFADNhfPCGGtG+Pq
         J0Sw==
X-Forwarded-Encrypted: i=1; AL+hErFHjmHC0WLcupU+GL/bU+6tLSBQqrrZF2bweX/fYLwipcp6qN12p9pCxSta9kqf3q5KpXXiltc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hhKa7+KEQ/N8wYlr+LMnE7ZHNy9FamQMtj5hopwZ+kAh8f16r
	uM/xQCpugHhC8SHfJVL+fanysq7EWcvU5nuJ01FsLHTWI9ss9CF5kcA3oDPcIz0lyAbkSTYENx2
	FS+KTTJFall8zNkiFwoKJ6Z2CXVTok285+MH002vobYPfWLVftA==
X-Gm-Gg: AYBFou2kQfAkVI1ixST5dy6OlQR6kpHjDSdCr5LR7xUapgmt9slsNBXhRSyACokFPrI
	hcJv5jaRqeIV5hXp9VsndDtZgbWoL9l3f+98jdFR2NENVt8kBBQwqjVemeVoMza3paBgHVp4x1L
	htJFu56SQBsd4j3LDwEdWkAoeXb4FGR+D9hIf/7Nj7CO52MdVqz8YZ501jDMJfzXa3sMliMRLJ8
	VhTAAq/sdf+qAZbZJzBt10/VM4Sp8VRUgGvaapXxQxylD+5+zAHm/4Pw6/A96vd0nbehdXpXOsr
	1EVepmHH4soc0nYFAoJZshG4AFi6XyfvwcPpDG+4KJ39Pa1uehhIYqIrq9YoDQaeiqYh4CXSpKG
	gug==
X-Received: by 2002:a05:622a:587:b0:533:2c5b:d668 with SMTP id d75a77b69052e-5552791d57amr56048301cf.30.1794329565571;
        Tue, 10 Nov 2026 08:52:45 -0800 (PST)
Received: from zx2c4.com (mail.zx2c4.com. [104.131.123.232])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5550b34ee67sm504721cf.17.2026.11.10.08.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:52:45 -0800 (PST)
X-Relaying-Domain: zx2c4.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1794329564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73EB4AvVq0oZ3UvAs/LOaer8lWZsO6R1BH9jbjOLBYM=;
	b=Lqb/W/g7LlfPsRDHPNkvCo76SKcVoVMyWwgdEyMnLOzYIhRNWtp7RjfsM449gZzhI7KPVF
	U3hTMmTiniZ8poNZfjAR3AH34/cO6F4gMx0Iar3TorRUkO/usMhE8yVfERSfGSrTWFtNeN
	NDTde3/UWGV4IfK/KU8/+LdtBkrnNr8=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id da1fd513 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 16:52:44 +0000 (UTC)
Date: Tue, 10 Nov 2026 17:52:42 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Alexander Ildiyarov <alex@badcode.im>
Cc: alexvancasper@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] wireguard: account peer and allowedips
 allocations to memcg
Message-ID: <avNL2piP_E5IJ9OI@zx2c4.com>
References: <20261105140815.92841-1-alex@badcode.im>
 <20261105140815.92841-2-alex@badcode.im>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105140815.92841-2-alex@badcode.im>

On Thu, Nov 05, 2026 at 05:08:14PM +0300, Alexander Ildiyarov wrote:
> Peers, allowed IP trie nodes, the per-peer dst_cache and the per-device
> hashtables are all allocated in the context of the process that
> configures the device over netlink, but none of these allocations are
> charged to that process's memory cgroup: the wg_peer and allowedips_node
> caches are created without SLAB_ACCOUNT, and the hashtables and
> dst_cache use plain GFP_KERNEL.
> 
> The amount of memory is bounded only by MAX_PEERS_PER_DEVICE (2^20) per
> device, with no limit on the number of devices or on the number of
> allowed IPs per peer. Since WG_CMD_SET_DEVICE uses GENL_UNS_ADMIN_PERM,
> any user who can create a user and network namespace can do this, and
> thereby escape the memory limits of the cgroup it runs in.
> 
> For example, a process in a cgroup with memory.max=64M that adds 100000
> peers with 20 /128 allowed IPs each grows Slab by ~790 MiB, yet the
> cgroup's memory.current stays below 1 MiB and its memory limit is never
> hit.
> 
> Fix this by creating the two caches with SLAB_ACCOUNT and using
> GFP_KERNEL_ACCOUNT for the hashtables and the dst_cache. The keypair
> allocations are left alone, as they happen from the handshake worker and
> are bounded to three per peer.

I wasn't aware of this trick, I think mostly because most drivers don't
use this. Does any other part of the networking stack do this? Is this a
normal thing?
