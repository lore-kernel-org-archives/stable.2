Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801413;
	b=r1oZ3dhyEDsGI7LWvfE6z632DzllSSvtLVxCqGXK/sRdCar1PxamvSbWzsCx8L4raWma
	 68v8IVdUiIzaQRVq3F6sk5ji0950vfO2m597bCT3+FPmnWMtEObY2M6186SlGQIZ3do05
	 TopeJQNsz19iJfAA+se1xJNfc0CgxlRWukROlV9RckdRWsddeMGaf3T2vWdK+5Jv+BmZE
	 MUCw40tXUa2uq2izKvRZikb/Mx02YQnWRWHvz+mC/Thtsuz5kI6XHbzlnWHc2B+X2u15u
	 rj8L9YLIe2J+mMyeWoewOn0K55Pwa9XsEtWLPvgmBAEplV7lpn0AHhhjYMpPb5MD8pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pU9Xk2Mqh993PZoYBYSJcD5UEr4iVVzCEZGF3w+CH3k=;
	b=QayqyUY7kTq49Y9S5rLGuF5ClQjLwWbuMAmL6qBsJ4amiCqrgUT9F31jTSoAMN2i6GNj
	 w34tN0fmT3XEZ0iQVq/JXPb6ZYnnvUXomdB/ogoIkH0+iIaluMrsDpBypHow9ULqXmreg
	 6RihuSLURT/rc68j275Z3DNsIIuy2KS6VFnFIsHZBWCOSSfoDdinVbU6LIKdCW4qTo6jS
	 QVak0Z4KtwTuEoJKzACHwmkvsySDpaz7gVT/FDJQ9tFL4uPCrI891hw8ymtCE83B/jLOy
	 OxKA68JiKIfSdyzkGzMuJwjsQxc7UNJDFfI2N5r9ZdY8iNfPgZ4aalX5Xr8Ws7Yk8lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w2lbzxZw;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7581F606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7581F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w2lbzxZw
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-385d8a00598so12821941eec.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795801411; x=1796406211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pU9Xk2Mqh993PZoYBYSJcD5UEr4iVVzCEZGF3w+CH3k=;
        b=w2lbzxZw5pzl27cd/sQqEEa0dcgRQDHWtC4WlKCzmY+/Op1n+feOzCNsgu4Qolw6fI
         SkhO6lQgGWBvIaNm3USmx+Ic4l0B+ssyTCNWNb1azkJ8WAOw4kNjGkMBypOg7l+2e9SC
         8sNBbgpW1mKfgEURVGcjjBsgeWyoIF64PXkdUcBIk0sifAN6LRwRxBfFrAuRGcXrsSCy
         2/CJb9MZUt7M5oBGDn03+GB/SFh4gj+aK9r2YHgiHqr/RIf2Bl5Ma/eYaLQxqOEz/rME
         /jwTvrgYGJyIw07G/YFRCWu6itP7Q2k4/RA/nhXOyeXMxSwwXg+7TQR4bA7DEzA4BeER
         TKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795801411; x=1796406211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pU9Xk2Mqh993PZoYBYSJcD5UEr4iVVzCEZGF3w+CH3k=;
        b=QVlkmEx3+UwbRDQTPKkW1zW562SqmLfbvQ40YnU1KEVaU6ow8+XkZjIZnIInWQbtxv
         U3GlfvsoO2AMBsQl6XJc/CMT3+MOg7vr3AdRfw8pr/E9fEbZYQO+dvB3ZJfeowLU1nSm
         uY+ccct/u4XnZ3E5nEINcBcbydJmRfYswBKRwKH5bvjBW+YKq3tkIiQ4s/mOktrnew8A
         1Xo9wgPhinlslkuAESNyvLeYhv2zpk91T/eD2NtY8JRM7f0Ci9BFvZXTzlU2bW0RlU+o
         jV+kTC3ElPVcb23KTk6eT7MdhvQeeYa4ZkZIcgawEdG7nbbkGtmtlz8VGGIhliVXJ3iv
         09zQ==
X-Forwarded-Encrypted: i=1; AL+hErHuo28ZeZt3lJ/uxwCLa70hQkyUnbCbQk7flTC91Sm5kUxIdHjEQX2QR/aFCg4BwIAGVbTcRE4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dhgTpNQFF+O3WhnEeRfqu/1xH0Q02P0lzGbQC4vX+Qt3e5afc
	0qKooAzQzYxMAoHEkkC2NejmjyGYXtmqoV/uvefKbdqA9VPb7lakkwRH
X-Gm-Gg: AZFdTZc0av3XwhydkT2lPvSzamR/RKuL76Rt0y5qz/eWXB6cUzGHU2TE8rK3dS32DnF
	H5F9qRN0ewSIJOrXG82eZmYXMhqA60xZ7resUP/75oaeTWDLUBqFva10l8DC9OJNruJjY3iZHRX
	e3D2TvIm01Vh+4chDZEe+dgc4JkP53ZU4S+lKybSuHJi6G3154nUD9jKYsWJgnJ3pg6G4k9aznM
	2/+wQgGWOReJoJuf0o7tC3JI5/VVkDnkouuIvwQkvAlXCuYT2S2YxKZnJcp3/A95uYfvg9+An7B
	0vHlnui2Z2J6qPVLMa/ioU+38oFR09I+7htew4ELgs6x1KweKR/PxeWjjyINwTKhgMUqNeW0sKN
	dtbyNuP5OnvvgQ4qhqi+xD4VZauNY1YB7UvirC8g55qMLOCLveidck+HVuuXfbaOKn2plywd3/H
	vWVOpodAb5vLmp5usWqNSP1fxTZu/ajOg+hC7uRAPbLMknz/W6lzgQhfdoDcknyf+Ty+Km1vJ5Q
	Rz5NhfyFhjuzX5PjyjYofNsfihj67opHbA1LUey7UjyIFoPIf5B259c6vgV6vgLY/Gqzrimj7eW
	Ihqc+sjN/leHiTQxHpgKTrLcDmsSTOluvvbEWsJc19CJYvxL97w536TFfUs=
X-Received: by 2002:a05:693c:8843:b0:386:b429:fe0 with SMTP id 5a478bee46e88-386b429175cmr14278377eec.16.1795801411155;
        Fri, 27 Nov 2026 09:43:31 -0800 (PST)
Received: from houminxi ([61.170.160.92])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7fc3sm66064276eec.8.2026.11.27.09.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:43:30 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	davem@davemloft.net,
	dev@openvswitch.org,
	echaudro@redhat.com,
	edumazet@kernel.org,
	horms@kernel.org,
	i.maximets@ovn.org,
	i.maximets@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	matttbe@kernel.org,
	netdev-bot+sashiko@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	stable@vger.kernel.org,
	willemb@google.com
Subject: [PATCH net v7 0/3] net: openvswitch: fix a feature leak on a failed change
Date: Fri, 27 Nov 2026 12:43:12 -0500
Message-ID: <20261127173039.ovs-features-v7-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovs_dp_change() records the requested features in dp->user_features before
it updates the per-cpu upcall port IDs, and that update fails with -EINVAL
when the per-cpu-pids attribute is empty or its length is not a multiple of
four. The request fails with the new features already recorded, while the
code that takes the reference for TC_RECIRC_SHARING never ran, so a later
request that clears the bit drops a reference that was never taken.

The first two patches are the fix, split so that the single read of
dp->user_features in queue_userspace_packet() stands on its own: it closes
a separate and older oops and carries its own Fixes: tag. The third patch
adds the selftest. The series is three patches; v5 had two.

These issues were found by code inspection with LLM assistance. The
failed-feature update was reproduced on the unfixed parent 2a324a58a084:

  # the rejected set changed the features
  TEST: ovsdp: failed set keeps bits                        [FAIL]

The upcall race and the reference-count warning were not triggered;
those parts rest on code inspection, not on a runtime trace.

Tested on x86_64 with CONFIG_NET_TC_SKB_EXT=y. Both new tests and the
full 21-test OVS suite pass on the patched kernel. The baseline selftest
scripts also pass all 19 cases on that same kernel.

v7:
 - Say what the comment in queue_userspace_packet() guards: the choice of
   hlen, not head room. Sashiko.
 - Correct the commit message of patch 2. Clearing the bit in the reset
   path drops this datapath's reference to a kernel wide key; other holders
   keep the key enabled, so the packet path is unaffected and what was lost
   is a reference. Sashiko.
 - Narrow the comment on ovs_dp_set_user_features() and the @user_features
   kernel-doc to what is actually marked, and name the readers that still
   use a plain load. Sashiko.
 - ovs_add_dp() returned the status of registering its cleanup command
   rather than the status of the add-dp it ran, so a datapath that was
   never created was reported as a feature mismatch. It now returns that
   status. Sashiko.
 - Use f-strings in the prints this series adds, so the selftest patch adds
   no new ruff errors. NIPA.
 - Cc Willem de Bruijn, Jamal Hadi Salim and linux-kselftest, which
   cc_maintainers asked for. NIPA.
 - Rebased onto net 28a371228d4e.

v6: https://lore.kernel.org/netdev/20261124145033.627044-1-houminxi@gmail.com/
 - Split the single read of dp->user_features out of the fix. It closes a
   crash that aea0bb4f8ee5 introduced in 2014, and folding it into a patch
   whose Fixes: tag points at 35d39fecbc24 hid that from a stable backport.
 - Move Fixes: and Cc: into the trailer block; they had prose below them.
 - Read the field with READ_ONCE() in ovs_dp_set_user_features(), now that
   every write to it is a single WRITE_ONCE(), and clear only the recirc
   bit through one helper instead of repeating the mask at two sites.
 - Carry a changelog per patch in the notes under ---, as Matthieu asked.
 - Quote the variables the new selftest helpers pass to subprocesses, and
   name both conditions that make the kernel reject the per-cpu-pids
   attribute.
 - Move Reported-by: to the kernel fix, with the link to the report.

v5: https://lore.kernel.org/netdev/20261118065435.2367014-1-houminxi@gmail.com/
 - Use an empty per-cpu-pids attribute to make the update fail, instead of
   relying on the masks cache path. Suggested by Matthieu Baerts.
 - Report the datapath that cannot be read as that, and not as a feature
   mismatch.

v4: https://lore.kernel.org/netdev/20261115163134.3202677-1-houminxi@gmail.com/
 - Take and drop the reference in one setter, and call it from every path
   that changes or clears the recirc bit, including
   ovs_dp_reset_user_features() and __dp_destroy().
 - Clear only the recirc bit in __dp_destroy(), so an upcall that is
   reading the other bits keeps seeing them.

v3: https://lore.kernel.org/netdev/20261110174651.972936-1-houminxi@gmail.com/
 - Describe the user namespace path in the commit message.
 - Check the feature bit and the reference count in the selftest instead of
   only the return value.

v2: https://lore.kernel.org/netdev/20261108123424.2825403-1-houminxi@gmail.com/
 - Split the selftest into its own patch.
 - Add the ovs-dpctl set-dp command the selftest needs.

v1: https://lore.kernel.org/netdev/20261107113403.797779-1-houminxi@gmail.com/

Signed-off-by: Minxi Hou <houminxi@gmail.com>

Minxi Hou (3):
  net: openvswitch: read the datapath features once when sending an
    upcall
  net: openvswitch: do not record user features when the change fails
  selftests/net/openvswitch: check that a failed set keeps the features

 net/openvswitch/datapath.c                    |  72 +++++--
 net/openvswitch/datapath.h                    |  10 +-
 .../testing/selftests/net/openvswitch/config  |   3 +
 .../selftests/net/openvswitch/openvswitch.sh  | 201 ++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    |  74 +++++++
 5 files changed, 342 insertions(+), 18 deletions(-)


base-commit: 28a371228d4eb4857cc31eeb1a0d7d01e9c3ea2f
-- 
2.56.1

