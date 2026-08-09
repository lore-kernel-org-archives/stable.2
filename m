Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8E41A6800;
	Sun,  9 Aug 2026 02:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242481; cv=none; b=F1NCByI8mHGmJREoDvvvobL+LSvvuGSaSM6v34gHniy4RLt6E+h7DGHnd+byWRDSvGg1IY66n1toxabcCJWPhaiHQxsWPCoxCjxgefVcLGL4sYEXq5ZAB+Afoc2QnUY9VmygXKQrNbOuocoWPGk0R54b04EZCp3MVvDK4yX77kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242481; c=relaxed/simple;
	bh=Tjoe12JYyR9weGjE+jcjd8mUOkAu8zSPNPPrgfOdPWU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XCCJlCFhpAlxvSUEKJQyqmYPBQu+3shp3/yR5g8mSJ0btPI2+jFDfCrTO4tohNlF1Y2RVj73/4tNUxzdUNe+j+e4kjVmgBGoGTG079OTONN3z7aGVVBRrqujombT6hKD3AmyI0dvj2ioxyx6xlpff25LHfD9mFD/eRyww7KdQAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr8Z5uro; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr8Z5uro"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD8A5C2BCB8;
	Sun,  9 Aug 2026 02:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786242480;
	bh=Tjoe12JYyR9weGjE+jcjd8mUOkAu8zSPNPPrgfOdPWU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Vr8Z5urogCSWXJIwL+N2wFhZ71kqgU5oT+lTV/EAW1dbgp79s7hoUEkxsi3NXWvha
	 wIz8UcD4x9ap9UsHqbNZsJ7t+JmsBbP0XQ8P9AK5z+gnm56wgE4ZALNe/TWbWZpute
	 pRZDUNbc2nQo+wlGrpzRyGsP6tkPBm85VmsQHnCgE6Qwy4PfpeW0PzldJqCMVQyXQ3
	 e5yKLBvjgz4nTeRBQ6E5ptqLYTCEwG2gtjIuGCqQptNkpUs3tuVUbLSLrGftNrbMbZ
	 6BIE6U5YOY8U5UeozC/Hmy0M/NdA38ZYQ9fo2ulMyQQi2cLxxv0jxa5bPQj7+7Pxtg
	 h9f86LFYiVRjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A86C5AD48;
	Sun,  9 Aug 2026 02:28:00 +0000 (UTC)
From: Fan Ye via B4 Relay <devnull+fy15309206903.gmail.com@kernel.org>
Subject: [PATCH net 0/2] net: thunderbolt: two fixes for the failed
 bring-up path
Date: Sun, 09 Aug 2026 02:27:59 +0000
Message-Id: <20260809-b4-tbnet-hopid-v1-0-9a8c7f5f0ba9@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK/ld2oC/yWMQQ6CMBREr0Jm7U9qA4hexbigZZDPopC2GBPC3
 a26fJN5b0diVCbcqh2RL026hALnUwU/9eFJ0aEwrLGt6cxVXC3ZBWaZllUHaelHNvXF9q5Bkdb
 IUd+/4B3lhsd/TJub6fM3heP4ABLsPe93AAAA
X-Change-ID: 20260809-b4-tbnet-hopid-6ecfe5472ab5
To: Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Fan Ye <fy15309206903@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786242479; l=2114;
 i=fy15309206903@gmail.com; s=tbnet3; h=from:subject:message-id;
 bh=Tjoe12JYyR9weGjE+jcjd8mUOkAu8zSPNPPrgfOdPWU=;
 b=QJ1OZDJKIK2M1C+Z2MuggxBYmu5KRbY1M0f/6gx51Mpwf/FT3KQTnOIe41TTY56kBxonkGAM8
 jZF5PDHbN87BdmhiqSsXp2EyFRVF6qsWgh50KptbU0iesymJ1VvVoCN
X-Developer-Key: i=fy15309206903@gmail.com; a=ed25519;
 pk=6QsQIrI/kruYWIJyCH9ntPMXsHCqF5JtK/DCMtOCzdc=
X-Endpoint-Received: by B4 Relay for fy15309206903@gmail.com/tbnet3 with
 auth_id=929
X-Original-From: Fan Ye <fy15309206903@gmail.com>
Reply-To: fy15309206903@gmail.com

Both of these are reached through the same branch in
tbnet_connected_work(), on an ASMedia ASM4242 host-to-host link, when
the peer drops out while a connection is being brought up. Cycling the
interface down and up 200 times over 80 minutes hits that branch 23
times across the two hosts, with no fault injection.

They fix two separate defects and neither depends on the other for
correctness - each leaves the other's defect in place. Patch 2 does edit
the lines patch 1 adds, so it will not apply on its own and has to come
second.

  1 releases the HopID the allocator actually handed out when it is not
    the one that was asked for. Today that id is simply left allocated
    for the rest of the XDomain connection.

  2 marks the connection as no longer established on the failure paths,
    so the next tbnet_tear_down() does not run a second teardown over
    work that was already undone. That second teardown stops rings that
    were never started, which is a WARNING splat and is fatal under
    panic_on_warn, and it hands back a HopID this connection never owned.

Measured on two ASM4242 hosts from a cold boot, no module reloads, only
the thunderbolt-net module differing between the runs:

                                        without      with
    failed to allocate Rx HopID          11 / 12     9 / 13
    ring already stopped + WARNING       22 / 24     0 / 0
                                     (host A / host B)

Two further patches from the same investigation touch
drivers/thunderbolt/ and go to the thunderbolt tree separately.

Per-patch notes, including what I am not claiming, are below the cut in
each patch.

---
Fan Ye (2):
      net: thunderbolt: Release the Rx HopID that was handed out on mismatch
      net: thunderbolt: Mark the connection down when bringing it up fails

 drivers/net/thunderbolt/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
---
base-commit: 06cf61899d6498b33e4b7c87d99d5bd471ccc375
change-id: 20260809-b4-tbnet-hopid-6ecfe5472ab5

Best regards,
--  
Fan Ye <fy15309206903@gmail.com>


