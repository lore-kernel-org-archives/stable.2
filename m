Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B5B2F8E98;
	Tue, 11 Aug 2026 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454450; cv=none; b=OXs0oWMUCbHppnbI4Kmr1neBfBaug+nh6D1c4HvEf4lxalbfLbJiFsZkJsBoXP2T4iJzUuE1FsbJzph2+tRbMSaYuiok0JffqY/fbibFyn2i9WCgn5GxcyMKfdWYdsCl2PzO7LlhzmrZerFfee9Q/bSO9fmYUsxsi7crrLQADp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454450; c=relaxed/simple;
	bh=1cUEhKpwhbhOlu1jJZ6mAX5yeVy7AZ4oG+h0MJFNlQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KqQ/CMAPKdgrSo0J3oZjRsEh9CURuUEoKAXq1xIxJq6t7Dfbahb+juTanc5Y9NmFq4gL7JPNA2YrMRnosl9ILhAAEDRkwwaDr/VY/zk2mKGLnk29vgY53AzSOmtREdMjWMBzl9PWWGaH6J9aazTJeptpq3jV60IBXzdIf+FYppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETfPsxET; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETfPsxET"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8607CC2BCF5;
	Tue, 11 Aug 2026 13:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786454449;
	bh=1cUEhKpwhbhOlu1jJZ6mAX5yeVy7AZ4oG+h0MJFNlQA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ETfPsxETaXon5QiiAcaNd/u0gdBhTjHZkhVjkvCHWP9Y0x4JipLBO3M0McNl0Xcec
	 NxefQfZSnuaJUjh7JgF7NTor9mZoHXwzyJXks9qyR8FRNkrdtddhhN0LMCFVbCZpP7
	 TbUWQ95NSbv14O0maTFqpQ/9xTb+upzAdq0Wi9GQiWglSijFcYcUDQNNEV6U7lNX8T
	 oXjAqEuG6K60NAN3SQ/5pXnaU/uqvF7kM71yvwDdL9Ce6V4owfpJu7ALsy05KUqPb1
	 j93u4od1v70YuuAoXbx4v+ksIbFpQ7Q8xB7uR1LTT2CSWCo4SluyAiN1GAz4cBUYVe
	 N0VhDNkq84Svw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717D4C5B572;
	Tue, 11 Aug 2026 13:20:49 +0000 (UTC)
From: Fan Ye via B4 Relay <devnull+fy15309206903.gmail.com@kernel.org>
Subject: [PATCH net v3 0/2] net: thunderbolt: two fixes for the failed
 bring-up path
Date: Tue, 11 Aug 2026 13:20:48 +0000
Message-Id: <20260811-b4-tbnet-hopid-v3-0-9e75d1b51331@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALAhe2oC/yWMSQ6DMBAEv4L6nJHwwiK+EuUQ4wEmB4NsByEh/
 h4nOVarq04kjsIJQ3Ui8i5J1lDA3CqMyzPMTOILQ9e6rXulyFnKLnCmZd3Ek2+s7qxypjUeRdo
 iT3L8gneUGx7/Mb3di8f8TeG6PrSTBmZ3AAAA
X-Change-ID: 20260811-b4-tbnet-hopid-d542741b363d
To: Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Fan Ye <fy15309206903@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786454448; l=1416;
 i=fy15309206903@gmail.com; s=tbnet3; h=from:subject:message-id;
 bh=1cUEhKpwhbhOlu1jJZ6mAX5yeVy7AZ4oG+h0MJFNlQA=;
 b=/a2kRJtmMh7Lp1jXHqXUcVtWdTmUYeqNFUSfzjP9GrQ6Y6hCcvM8EfV2eZfrLFTvgki9a1ZPo
 eyg4x9DzkY6AFUxktvGt54Zg0SkM69UgwlMjtzCYWWd0C4ZCwVIhHJ9
X-Developer-Key: i=fy15309206903@gmail.com; a=ed25519;
 pk=6QsQIrI/kruYWIJyCH9ntPMXsHCqF5JtK/DCMtOCzdc=
X-Endpoint-Received: by B4 Relay for fy15309206903@gmail.com/tbnet3 with
 auth_id=929
X-Original-From: Fan Ye <fy15309206903@gmail.com>
Reply-To: fy15309206903@gmail.com

Two separate defects reached through the same branch in
tbnet_connected_work(), found on an ASMedia ASM4242 host-to-host link
when the peer drops out while a connection is being brought up.

  1 releases the HopID the allocator handed out when it is not the one
    that was asked for.  Today it stays allocated for the rest of the
    XDomain connection.

  2 marks the connection down on the failure paths, so the next
    tbnet_tear_down() does not run a second teardown over work that was
    already undone: stopping rings that are already stopped, which is
    fatal under panic_on_warn, and handing back a HopID this connection
    never owned.

Patch 2 edits the lines patch 1 adds, so it has to come second.

Changes in v3:
- Cut both commit messages down after review; the code is unchanged
  apart from the comment on the new helper in patch 2, now one line.
- Link to v2: https://lore.kernel.org/netdev/20260810-b4-tbnet-hopid-v2-0-0eee557e75df@gmail.com/

---
Fan Ye (2):
      net: thunderbolt: Release the Rx HopID that was handed out on mismatch
      net: thunderbolt: Mark the connection down when bringing it up fails

 drivers/net/thunderbolt/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)
---
base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
change-id: 20260811-b4-tbnet-hopid-d542741b363d

Best regards,
--  
Fan Ye <fy15309206903@gmail.com>


