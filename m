Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF03B19A5;
	Mon, 10 Aug 2026 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354756; cv=none; b=MfGmqHEdm2sHAgyU5xuZIdfEcW6cvjx43CrclhZV42/5rjLbyf9ECjHudzUgkQk1B146PHlq98PDhWqzVBmj0VK6fnSMvC2MbC4WvaFVh207SV7cSU7k158ds9gxJ21urnWzfzMUpSZ/5SfUYtOtjCmQ/u/CQZ47AktQu2j7OE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354756; c=relaxed/simple;
	bh=nGqE/4AOG6zzAkUJEdO8J8/HREV3k3WXLcAgGhLwipI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wdg2w8482aELavyYtu6AmMEEIhiSenpJVT3Pfc38eB4jvmOtOdBqkf7oj60elUYrE7Cr+Q0cFU//WFzwkUkdcTbXjeJUSThIZVtJz3iCA0ZOYkxHkODE4XoV672vrbcx1uaqGw/ICWq6mGERCryDcgVpYMLo1m2hV0qF76X+hdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppF7sdCj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppF7sdCj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51792C19425;
	Mon, 10 Aug 2026 09:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786354755;
	bh=nGqE/4AOG6zzAkUJEdO8J8/HREV3k3WXLcAgGhLwipI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ppF7sdCjRmCfWbXwu/R6PE+tCE+8328BMp2jaW0hvF44mNoxWrhOX6iYIk/evKa40
	 Br8I48+R6ghWRTdpTJrDfYtQIm9YID9V5jRusGNCQ8HsmevUZn+Hc+x+QASbblPhqG
	 0D/D0Nk+VB2Yk8Q8TVTuNT4l+++ivINJnnMmhZYgAUY5l+xfQziuBtvGpuLbj0zDXC
	 XX+pbaFCRhxvZbNn2SwPDSm0TBHu/AlSnyxsUYK58b7zWRAz48svDpHIsM5eLANXz1
	 IZj3SOakb5ahSwDG8EZECQaSj8lw8E32DR3iN8CkWLfZQ3QYMvQDocaELZBuTQAKbQ
	 VVNnEVbA6JP7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A96C5AD7B;
	Mon, 10 Aug 2026 09:39:15 +0000 (UTC)
From: Fan Ye via B4 Relay <devnull+fy15309206903.gmail.com@kernel.org>
Date: Mon, 10 Aug 2026 09:39:14 +0000
Subject: [PATCH net v2 1/2] net: thunderbolt: Release the Rx HopID that was
 handed out on mismatch
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-b4-tbnet-hopid-v2-1-0eee557e75df@gmail.com>
References: <20260810-b4-tbnet-hopid-v2-0-0eee557e75df@gmail.com>
In-Reply-To: <20260810-b4-tbnet-hopid-v2-0-0eee557e75df@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, stable@vger.kernel.org, 
 Fan Ye <fy15309206903@gmail.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786354753; l=5006;
 i=fy15309206903@gmail.com; s=tbnet3; h=from:subject:message-id;
 bh=dxRG5Rjf5ZiUXF6CKSVFMQZqqMQy7DhVPsZQXdmvpWs=;
 b=selz4AO7BkV93tjkooiBEV99OZiQk+41vknpzxPHoEf7veTy3nLJU+FPNl/ftT7keRKhqcs1Q
 zoLQQPiNoeMD5p341oGVvNFBy4BKKvAPcqR48w5P2BZ9My0p91HdXSt
X-Developer-Key: i=fy15309206903@gmail.com; a=ed25519;
 pk=6QsQIrI/kruYWIJyCH9ntPMXsHCqF5JtK/DCMtOCzdc=
X-Endpoint-Received: by B4 Relay for fy15309206903@gmail.com/tbnet3 with
 auth_id=929
X-Original-From: Fan Ye <fy15309206903@gmail.com>
Reply-To: fy15309206903@gmail.com

From: Fan Ye <fy15309206903@gmail.com>

tbnet_connected_work() asks for a specific input HopID and treats getting
a different one as a failure:

	ret = tb_xdomain_alloc_in_hopid(net->xd, net->remote_transmit_path);
	if (ret != net->remote_transmit_path) {
		netdev_err(net->dev, "failed to allocate Rx HopID\n");
		return;
	}

That call ends in ida_alloc_range(&xd->in_hopids, hopid,
xd->local_max_hopid, GFP_KERNEL), which allocates the lowest free id at
or above the one asked for. When the
wanted HopID is already taken it does not fail - it succeeds with the next
one - so this path returns with an id allocated and no reference to it
left anywhere. It stays allocated for the rest of the XDomain connection.

Forcing the branch by occupying the wanted HopID first shows the returned
id is a live allocation, not an error code:

  LEAKPROBE squat=8 requested=8 local_max_hopid=27
  LEAKPROBE real alloc ret=9
  thunderbolt-net 0-1.0 thunderbolt0: failed to allocate Rx HopID

Release the id when it is not the one we wanted, matching what the error
unwind at the end of the function already does for the expected id.

Fixes: 180b0689425c ("thunderbolt: Allow multiple DMA tunnels over a single XDomain connection")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Fan Ye <fy15309206903@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

---
These four came out of one investigation on a pair of ASMedia ASM4242
hosts wired to each other. Apply them in this order: the second one
touches lines the first one adds, so it needs that one underneath to
apply at all, and the last two want the first two under them for the
reason below.

  1 net: thunderbolt: Release the Rx HopID that was handed out on mismatch
  2 net: thunderbolt: Mark the connection down when bringing it up fails
  3 thunderbolt: Report DMA path teardown failures to the caller
  4 thunderbolt: Stop waiting on a path pending bit that never clears

This one is number 1 on that list.

1 and 2 fix two separate things that happen to be reached through the
same branch. Neither depends on the other for correctness - each leaves
the other's defect in place - but 2 edits the lines 1 adds, so it will
not apply on its own.

3 and 4 do want 1 and 2 underneath: the warning splat that 2 removes
fires throughout any prolonged run of link cycling, which is what 3 and 4
have to be measured across. 3 makes teardown failures visible to the
caller at all; 4 stops the teardown paying for one that cannot succeed.
Note what that pair does on this particular router - 4 leaves the first
failure to be reported and silences the rest, so 3's new signal fires
once per adapter here rather than on every teardown. 4 is the one I am
least sure of, for the reasons in its own notes.

Found on an ASMedia ASM4242 host-to-host link, where the branch is
reached on its own when the peer drops out while a connection is being
brought up. Cycling the interface down and up 200 times over 80 minutes
hits it 23 times across the two hosts, no fault injection involved.

I am not claiming a user-visible symptom for this one. Every one of those
23 occurrences recovered on its own, 19 to 21 seconds later, because the
XDomain connection ends and its ida is recreated along with it, which
also disposes of the leaked id. I could not reach the branch twice within
one connection, so I cannot show the HopID range being exhausted either.

What the patch fixes is the leak itself. The patch that follows has the
measurable effect, and does not depend on this one - they are separate
defects reached through the same branch, and with only that one applied
the id this path obtained is still never released.

I could use help with one thing. The only way I found to reach this
branch is to wait for the peer to drop out at the wrong moment, and the
XDomain connection ends with it, so the leaked id goes away with the ida.
If anyone has a setup where the branch can be hit twice within one
connection - more than one service on the same XDomain, say - that would
settle whether the range can actually be run down, which I could not
show either way.

v2:
- Add the Assisted-by tag Mika asked for.  No code change from v1.
- Pick up Mika's Acked-by.

v1: https://lore.kernel.org/netdev/20260809-b4-tbnet-hopid-v1-0-9a8c7f5f0ba9@gmail.com/
---
 drivers/net/thunderbolt/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 98893732bc6e..e5199a87ea7a 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -647,6 +647,8 @@ static void tbnet_connected_work(struct work_struct *work)
 	ret = tb_xdomain_alloc_in_hopid(net->xd, net->remote_transmit_path);
 	if (ret != net->remote_transmit_path) {
 		netdev_err(net->dev, "failed to allocate Rx HopID\n");
+		if (ret >= 0)
+			tb_xdomain_release_in_hopid(net->xd, ret);
 		return;
 	}
 

-- 
2.43.0


