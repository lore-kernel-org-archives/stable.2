Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795615928;
	b=a1zPdutYlbdKHKnfwG0myzAWle+BoLorAgHIR84istzZ9dh6K1C0GGH5Ronid/RzG2J3
	 ZRQofzxA2YpSnp7kmjCTPgCce7FLEvW9clOAGBfGV0p/RIuApLbmplzX+5btmqV3I/tMC
	 Wodek0KLRAw3wnvUzeUxUXPMQ7el6qsV7OUd+m7CUMb+ige5q4wata49mc3iikniUYVKR
	 WjbCwWDhQgkTaJqwMrMv1PF0uKZFeBv3dK753kNHKgRShi5ON80x5jcH698ve4jvzO7mf
	 dVkvHUMOXuUuJWjb20/sFgcIX9DR1z0Hy102o63YI87rpoaKh8MjfVUtQXuQ6mgKGzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615928;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=p9n/LLKZni3XY9y6YxGHGDOqPopQL3U+PYe7dZtYI4Y=;
	b=jD2BaQnpie9uyx+grSEeyqBp40bBzFupuiZdQsRUG9MfOfwUZrkvgQ9RReVHgIFBIyCM
	 Tbn6t+I1E4dtzIkpPGwxcE0gluecw1lQ6eEHXBnh+x6/aJ/VwKSt3hfjbY/iL0ZqKYohj
	 1w+EUvZ+jwP3Rl/s7ovG18HzmIS+w55z0t18rHjTIeD8pu1fSluW3Rrrew2Jz6ugh1d1/
	 C19Twdvce+jmmTG9uxeIz0hO0HAYp4JLip9pEHqAE5TPLO4PFkpG54Mk4B/tOLJfYyURw
	 CLSUpBKPbjyLRtMCGgWaQt4WW8okD9Nz6pKjejr7PrMJkq/NpDAmQuRVcMRt/LmaWRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjA5XQCb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2FE606A32E;
	Wed, 25 Nov 2026 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjA5XQCb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795615928;
	b=cQ3vqzplscss0lvwrqH6WRBe2VbNcLREBttC9n4EpQRuATrVaGJNftU27ERooU7vX+fJ
	 t4TphLuakj/jATmNALbxiXnTjNHian4tQzjhhaCKxdzVB9AHvSfAjp0gbs6aX4IGA54qf
	 ZvIQFw7imX0TRBE4Z752MfdKykoOK9P4lJR5SJu8Rg+2UvdDUVg4uYm2VOp4auJv0daJM
	 Gxs6ebBNZE0BRcvg1s/LjfexbvqxVP/ZFPbq8NCNr3C+T+A31AdgckfR7pNlQmTyhTDoV
	 ZKZg1EcWwdZY7pywv0wknZ8v2OVoSRUIikrOour/qVL5eiWM5cWiBn7IFA19Af2tDiw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795615928;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=p9n/LLKZni3XY9y6YxGHGDOqPopQL3U+PYe7dZtYI4Y=;
	b=w75293OkdlLI4U3RzD9K8xIH1MUuJunFKLrFWSaoFJI0fmKudHh0+ZIxhWYxsCxrQDDX
	 SPsFVcc3LKRYhqGOmhxvapzAg6ohgr+YWxyDC4OwOsX2e3WUKuGYXI62tcoHRcYPTfKHe
	 rVkuvF4AMqz1Y2+5wwgyqd4qvu8wzqCsZ+0VCJoQyrlkWLLTudanGxOz+oqMTwhMfAzPm
	 ACKmCmIbCr7K1nL320Ixnr3CwuKlaPsiYLb27OPrRx42mbaN/8SQb5xj6hMFhRcABvZt+
	 oPGZT0KsXM/kp/gF9kxaIHBNmGJ+/Ko455mGjbTvt6GSM4XDNg0TyLfkyEHkaaZ4TIw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A8AAA1F000D8;
	Wed, 25 Nov 2026 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795615928;
	bh=p9n/LLKZni3XY9y6YxGHGDOqPopQL3U+PYe7dZtYI4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bjA5XQCbUb8GzYygiWFjodmCpm6W7LjR4wbzGG4ud/ZYlcXRG2ml1t40vFr1EXVXV
	 GkeG45Z/LqWXTN4s0ssM8oJi+ESVUdrb/6Cue9kTYuqf8i6aGKOV4Jh1RrcRaBOOpA
	 l9RCxPycub3mhwl3zANhTk0JEH4nMDpYvdxdvZPQQkuOlGjB9opWqGQNRkwxsMUOms
	 EhaOJQwGYjCzkOKum1dLBn9aNO6NmpUpt62UgiZZs8ob7jXVE/zR2x82lLadhE71Td
	 5ATVk39S9Z73N1SnY+jWL82a7HJy2uw04uggqUy3E84W1H+zhGhgsRz1k5vZwQ0LYq
	 09x3U0pnS86Lg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 370094CEFE;
	Wed, 25 Nov 2026 14:11:55 +0000 (UTC)
From: Moe Mahhouk via B4 Relay <devnull+moe.flashbots.net@kernel.org>
Date: Wed, 25 Nov 2026 14:11:50 +0000
Subject: [PATCH v4 1/2] virt: tdx-guest: Fix timeout detection in
 wait_for_quote_completion()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-tdx-guest-quote-poll-v4-1-d89f26854b88@flashbots.net>
References: <20261125-tdx-guest-quote-poll-v4-0-d89f26854b88@flashbots.net>
In-Reply-To: <20261125-tdx-guest-quote-poll-v4-0-d89f26854b88@flashbots.net>
To: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Erdem Aktas <erdemaktas@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Dan Williams <djbw@kernel.org>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Jun Miao <jun.miao@intel.com>, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Moe Mahhouk <moe@flashbots.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795615914; l=2045;
 i=moe@flashbots.net; s=20261021; h=from:subject:message-id;
 bh=agGhuadNQQ9dfbu4Mm1Co5M81IUoruWqLo97nzaI1Tw=;
 b=n+1R/mqxg1HgiT3te4CZiWLoBsOFyS5bttKbZ/CnFYKgsbCQkqDpcFfFOmCQi4oTVBxBqiBTb
 UsorFDES3BBDQhMz7bEfuJgG4EA8Tp46EbauU18brB2hmCceBlJ+QLf
X-Developer-Key: i=moe@flashbots.net; a=ed25519;
 pk=hJTKfjLno/YESrpxMIKDJk34GM+/8Tol+24XK2b4xf0=
X-Endpoint-Received: by B4 Relay for moe@flashbots.net/20261021 with
 auth_id=1259
X-Original-From: Moe Mahhouk <moe@flashbots.net>
Reply-To: moe@flashbots.net
Content-Transfer-Encoding: 7bit

From: Moe Mahhouk <moe@flashbots.net>

wait_for_quote_completion() counts the seconds it has waited in i and
reports a timeout when i == timeout. That gets both outcomes of the
last second wrong:

- If the request is still in flight after the last sleep, the loop
  condition increments i once more before it fails, so the loop ends
  with i == timeout + 1 and the function returns 0. The caller then
  returns -EIO instead of -ETIMEDOUT, without the "GetQuote request
  timedout" message. Before commit 0f409eaea53e ("virt: tdx-guest:
  Return error for GetQuote failures") a timed-out request even
  returned success with an empty Quote.

- If the VMM completes the request during the last sleep, the loop ends
  on the status check with i == timeout, and the function returns
  -ETIMEDOUT for a completed request, discarding the Quote.

Decide on the Quote buffer instead: the request timed out if it is
still in flight when the wait ends.

Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
Cc: stable@vger.kernel.org
Reported-by: Kiryl Shutsemau <kas@kernel.org>
Closes: https://lore.kernel.org/all/atoHWgQF-0vlTRK4@thinkstation/
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Moe Mahhouk <moe@flashbots.net>
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 11d741da3b35..a5a53174f9d9 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -282,7 +282,7 @@ static int wait_for_quote_completion(struct tdx_quote_buf *buf, u32 timeout)
 			return -EINTR;
 	}
 
-	return (i == timeout) ? -ETIMEDOUT : 0;
+	return (buf->status == GET_QUOTE_IN_FLIGHT) ? -ETIMEDOUT : 0;
 }
 
 static int tdx_report_new_locked(struct tsm_report *report)

-- 
2.34.1


