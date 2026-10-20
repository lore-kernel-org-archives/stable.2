Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527016;
	b=RIUlwlG+mOfF19+6KkFHtSp3EcsirbkmtsMxTHPkHzrnctnR8Zym+TcSv4ya54tbUIgB
	 h7qldJmp7DzOhyhSngS0LNyom/hP7pcnSDdH1rXlyd3VA2Qoq6nisx6UHHW6N366NrK8/
	 MrCJY4O9d6+BcMGoVyqQtQR9rPiq0tK/B0pBPNVII+FxFR7buGTHJDIBh1tYIaF5O5JSl
	 woqoMdPB1K0OU6Ha0n3GFaX4EnqwEm+AhnvLQZNGr5UcX57VUmEbCNanob2b/UyH73pSh
	 XM8L/l9mzYve0//5RCzKaqSAwJkXs4EIsKpcianC2pxsHz0CUsFnxA16rGThxo/yWwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527016;
	h=DMARC-Filter:DKIM-Signature:X-Forward-Email-ID:
	 X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=EfjdhxM4k4Cnntfb3hihR8aLLPSQFq4ShY8oepxOovQ=;
	b=mJ3KXyR2SzfTA8GS6R1VpHDqJnwxDMqC7CR1sdYzwltut/i4ZnpZDQafbh9pLHeQGcfN
	 6+c5+dxwKi/IN6T2VYpwsDEpfHNIXIbr14wfODJpobRVZf77dEFAzVHr8P46pOjR4pq07
	 iqX3yuj/T2XPzgOAF403Y3eC1ZReot9Fz2nTy0BHOezwnDZaxZ7taxyAzOcxXaXha2o6I
	 BZMwFikzf1IpWWcKPfnrCiF+OZQHb0raKLb0WboQd9ja8S7B98upApbZfT09SAz3Yzo+w
	 uTkiWw5Q02dNPXPU0/YewlUJC2a2OXvXRjoDCeMCe1B3OUWHvec2Y6rtNk5wuwoFuYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alexs.space;
	spf=pass smtp.mailfrom=fe-bounces.alexs.space;
	dkim=pass header.d=alexs.space header.i=@alexs.space header.a=rsa-sha256 header.s=fe-034aa486fd header.b=EnCJ6MG8;
	arc=none smtp.remote-ip=121.127.44.66
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37C606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF37C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alexs.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.alexs.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alexs.space header.i=@alexs.space header.a=rsa-sha256 header.s=fe-034aa486fd header.b=EnCJ6MG8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alexs.space;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID: Date:
 Subject: To: From; q=dns/txt; s=fe-034aa486fd; t=1792527009;
 bh=EfjdhxM4k4Cnntfb3hihR8aLLPSQFq4ShY8oepxOovQ=;
 b=EnCJ6MG8jh5yBiwopkRyI58fVzUtXoR5M6wFnKs+yovG8LDqJzDVnV75T0ERS3348rzRKgTL2
 q9rPvv9TlgQfkfKRVwnViKTfvIg//ZX+h4cA8Qbe/1yRoc8txZiNbTfLm3EYdQxQ0CE8YKxAt/q
 O/zsmMEcJM4WRR5UZv9ZRWw=
X-Forward-Email-ID: 6ad7caa060e4441e50077465
X-Forward-Email-Sender: rfc822; linuxkernel+co@alexs.space,
 smtp.forwardemail.net, 121.127.44.66
X-Forward-Email-Version: 2.18.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: linuxkernel+co@alexs.space
To: stable@vger.kernel.org
Subject: Request: backport 2ee9836545e6 ("drm/amdgpu: Fix VCE 3 ring align_mask") to 6.18.y and 7.2.y
Date: Tue, 20 Oct 2026 20:09:27 +0000
Message-ID: <18e055c816c88bcf-14970a90@a-workstation>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Please consider 2ee9836545e6 ("drm/amdgpu: Fix VCE 3 ring align_mask") for 6.18.y and 7.2.y. It's tagged for stable but isn't in 6.18.57 or 7.2.11, while both have d5ab4c6a64ef ("drm/amdgpu: Implement insert_end for VCE 3"), which it fixes (6.18 since 6.18.46).

Without it, VA-API encoding on an RX 580 hangs the VCE ring:

  amdgpu: ring vce0 timeout, signaled seq=..., emitted seq=...
  amdgpu: suspend of IP block <vce_v3_0> failed -22

6.18.42 is fine; 6.18.50 hung three times in three days. Someone else sees the same on 7.2.6: https://github.com/rustdesk/rustdesk/issues/16324

The fix is one line and applies to both trees.

Thanks

