Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795754093;
	b=lBLzYaps6UKeRtGeT93BQNA4Guu3IXKeoGwbmRiRdmZ/W3coatF2Y0jbTgYbJzYSAy3n
	 hykmFfYuob6hgW7Bu+qWFrQllws94LIhETjPqbp4btqEyal/wMLYIEz9cKJ5t7wVzmp9a
	 dmEdKgVrgPfrUeWjfAeBUoYmgIwpCfrgifFCoxZlUiD0CT9Oz3zCwlx2hZYNtVd7wEOAl
	 bXerXedLObiJD5JEH5gWD976BTh4QyJKRjSBgVVncj4nN4C1lOqAmy3CkzAc9mgS6sMdB
	 VFQjdnpJ86/UGcD6eBf6JDLxs2GvjQVFNv1nQzf7w6DNnraE4VusO9V8Jp2H1MQfIGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754093;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=zcFjPmw9eptUqHUJABnzMf/G6iqaLqV4Cgs4sKoC2BY=;
	b=Yfr8G+P8552jFmAc1y7pElYMDMY6Xx59C/ZVy1hr2wr2CAuQbEgvpUD+cIOIMgAFPJ2l
	 fSodSSS/Hnf3qTqmMruqZ9kF3MdTU39tyGIZwgKhEvdBUlCxMQzk8CdfuNdRcN2ffPQf8
	 FYkP7hN8FxkfssNNQ2BRPNv0vOtMZwEfkLYvJXEvYqWTHQbPIwT5s7NEw1janIwqSy2Ro
	 xrqSp+jsArgL8kXdVTanU42LUA22VbE9vIq3q0+sA3r/g4n7bjRjFejv8MsQbe3nYluzb
	 wsUTCtOd7N0b065o/qmEaiKZLic/A4s3JYZqpqp5DZLOydZdvv8HCOChxVenLTQr87A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdxEa1no;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BB606A321;
	Fri, 27 Nov 2026 04:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdxEa1no
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795754092;
	b=MjGkyAvBp+Zjl+/H3p+M/7ql2014oaW9tRhvFUo9h4UiZiAC3O8eAJXnfy5gn4VOJpLR
	 prHUV9mE57TOqDqdZMIFLxX3E3kZzAU/jWTg+nG5cC+Vi6lODT7GdKOjD5aqtVnlmAsL6
	 M+C5ceT8dhR54PBmbgF5FDJC9R0klAr5FBb8/WQQGSIIJbKUa7tkrmjB/9WVBmXSy6s26
	 XmDIFuN26FERlAepANtnFTT9lFtwTUxN93b2m6QbKQ55AvvZ5LfI0ejglyVPdT6qdORqD
	 GhuuTxZ9d01p6mKQog65WXhw9viRojxfIyXoMC7L+0U2KSwHLQVPQLxhGQZOxPU23aQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795754092;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=zcFjPmw9eptUqHUJABnzMf/G6iqaLqV4Cgs4sKoC2BY=;
	b=y0hyjJKxA+oN4HIUNlWLWw4/ToPdEhXwSK9XyPBm7nlKNCp9M5i8z1rEuEfDTPzlgw7u
	 +jGcacbDLxmWyHwH2mdd03sHu7AnY+mP7F9nCdbZqhKWswMwOd49inIbm8rl/fwKubQas
	 PQvLP/IvvWxO341HzM3zKYFQAUM7IlkLz8HS7KXknQJqKQjncWFZuk3p/IoQNnYdLqyFS
	 gvZqJW3NAkf/dKqxOj2POVFtDnYKCdvMDISDp8ePaj1iS2eJI91wg+QaSFXfNXKHmelPa
	 edN1cH7SnJ2y0uoKXUZjV1ZOyU7sVySM9S7Xi8nTsXv7lZCkEGGC0jQW8fjDjFNAPdw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1A1061F000C1;
	Fri, 27 Nov 2026 04:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754092;
	bh=zcFjPmw9eptUqHUJABnzMf/G6iqaLqV4Cgs4sKoC2BY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=TdxEa1noeOfWiF9pMboEuhu+wlzjcGed4gKPEP4dG4l7VdbUZmSMg6UnZ4S33MNUG
	 R090z7rfRC4DhWnshiYR9Xaj7G1ugzMhy8ofMitBJ6imH1weDkJP8rd5qdTlIEPZzR
	 wFk1gtK3B9lZe14sn7eBnRw/HS2xJukYQwihPyhsgYKi8Ne9GDnm2Jr1DcPLi+fmF5
	 A6m08rZVAHFm3MRCPAJGQGTMjHBc/CHHdYjJ56w3eEdURsz3thvqQX6G/ggx4vldUT
	 zuuGIigqEtAc9gSyHmB9OULteL1gcaSsrDXeV8dkEj9UYS6HORpdpdknM0EBUDOhyn
	 Y7u/IfNCmgKJg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 91F844B56A;
	Fri, 27 Nov 2026 04:34:45 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH 0/2] ceph: tell the MDS when a closed file no longer wants
 Fr or Fw
Date: Fri, 27 Nov 2026 05:34:37 +0100
Message-Id: <20261127-ceph-drop-stale-wanted-v1-0-763882859c5f@clyso.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTvQxGKLVxEXafJrRyQNmaiF0
 rs36vJbvLeSIguUzs1KGW9RmWOFOTTkJxfvYAnVZFt7Msb27JEmDnlOrMU9wR8XCwJ3nRt9i+H
 Y24FqnDJusvzGl+vf+hof8OV7o23bAS7Z8N16AAAA
X-Change-ID: 20261127-ceph-drop-stale-wanted-44abc0e83728
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?PATRICK_B=C3=89GOU?= <patrick.begou@univ-grenoble-alpes.fr>, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795754083; l=1836;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=VHzb9ucE/pcleIt29IQpj4E990WPVnr2Hv/I0H5tNQU=;
 b=Skdr36wzJ2bP/RlBqANnT9or3k4xlUlkhf93YKc8H8PXvkXpIxi7jxxEV06ykgdruOcr/5QDv
 mZ5zhkANx9YDwAm2pD5MNyoZpkCFZBY3G/aGJiYZfoLItckPYhEdCQk
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

A single "tail" of a log file from one client can make the writer of
that file on another client over 1000 times slower, for as long as the
reader keeps the inode cached.  This was reported on ceph-users: a
simulation that runs in 38 s took about 15 minutes after one "tail" of
its log from the cluster front end.

After a file opened for reading is closed, we often keep the inode with
only Fr and shared caps issued.  These are all caps we retain, and since
commit fdac94fab799 ("ceph: skip updating 'wanted' caps if caps are
already issued") nothing tells the MDS that we no longer want Fr.  The
MDS counts us as a user of the file, chooses no loner, and keeps the
filelock in MIX; the writer has no Fb and every write() goes to the
OSDs synchronously.  Nothing in MIX revokes our Fr, so it never ends
until the inode is dropped.

Patch 1 sends the cap message when the MDS still has Fr or a write cap
in the 'wanted' mask of a regular file we no longer want.  Patch 2
checks such a closed file at caps_wanted_delay_min, like a closed file
holding write caps, instead of at caps_wanted_delay_max.  The writer
is back to full speed 60 s after the "tail" with patch 1, and about
10 s after it with both.

The same bug is in libcephfs; its fix and a qa test that fails on both
clients without the fixes are in a ceph pull request.

Link: https://tracker.ceph.com/issues/83627
---
Xiubo Li (2):
      ceph: tell the MDS when a closed file no longer wants Fr or Fw
      ceph: check the caps of a closed file the MDS thinks we read sooner

 fs/ceph/caps.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)
---
base-commit: 3f90412e989cb381d4bf96260468f5c7b2d08655
change-id: 20261127-ceph-drop-stale-wanted-44abc0e83728

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


