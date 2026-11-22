Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316870;
	b=yjPh31JemW4A44Hx1uR+VAQ3v6LQv6MVvr2Q2PMduVxTv5waZYhc4N7KoMRw/4ZK5UXq
	 XkzD3ySyd1t9+YhePHkSsaC8OkBidd4w6G3/4bPHZpK5ML5oT6T8JxvkU0V6x23HcqwWP
	 nle+4pfGQ6TaoRyuyoOsjYsI6QywhnKLQoFBx696a+6EVP1P37Zod5hQS+h3Rme2od+ET
	 25JZgAqJK/q6GkbdjsW7ZHbT6N/fOv5sMDkr50BR4fXo+vWdgw4JA5IBHoIaF7LmB2DPo
	 6Ouk2Fy/EWP7Uf5GO9Y5WfST+uAOc3lyujyi1aAncL30V2PX+tAB1Npbe65yJx2yKuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316870;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type;
	bh=bwNd8sLw6hbTvYHt2WvzdcBYIoTOOkkWoTy5JkcEDe4=;
	b=p4DihFPSZa7PkP2yQYIiiVXmqsGsCHYmXWyMwF2N26VW7lY+3DBWIMiaML6gFr0MiYlM
	 GuRU/UwwWJDnX+UL37hX+5X7b1iLHYsvfYXoYB8PItCcdBDCUp/c6AgyKWdS9bTaZjRCp
	 VRCtWIGWB6OCHd24AILukN7Cd2D8lK28MT0GgCaz+nF/ezYVk5cYkguCgAvmJl916RT2B
	 45o8Fx0PxOVzUMPY7kRAeHok01RMwV1XQgGGlO5kQu1tTGxxqazfjpfUpxfLcZXozCEF9
	 sGjbS0oZ6iQhR17OC3/apeYiA2176kImfEUQgimwY5dptfUII/JsVnx5YkwDlmXA6XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=O1OiLEeP;
	arc=none smtp.remote-ip=185.70.43.100
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254EC606A320;
	Sun, 22 Nov 2026 03:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 254EC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=O1OiLEeP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795316866; x=1795576066;
	bh=bwNd8sLw6hbTvYHt2WvzdcBYIoTOOkkWoTy5JkcEDe4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=O1OiLEePNn4iDA7PsrfhjOqYPcVbTdj+2K5cdrcV1yS1rECRGiHFn8kNl2Qyankcn
	 fu/OaRGf0VFQhuEMsujFik7y+8EFzAqxC+FUM0Mh6H8a+Js2jh+VKfXI/t6r0RIGlN
	 VNkpH6V9ILDzLx/ReHSrSUS4XS0BCYVKAZHTv+YB/3pzZbCU2ZLbpSpsxq5nlXo/8m
	 TFScUDdgKQ1s58fpGl3zAo7D9RvyR+KWVoYcJos6Li+AEIYhkWZk1Fi/lAgNqLeoLm
	 Z8SxagMjW619bNY1D8dqJaSDrhOjjOg3/h2mwpjUbOUzNLwmaOBNVsypffhyB79QmQ
	 xuOydqkD07rSw==
Date: Sun, 22 Nov 2026 03:07:39 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
From: YanXin Li <fadouse@pm.me>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net] net/sched: act_ife: return -EAGAIN after dropping rtnl_lock in load_metaops_and_vet()
Message-ID: <20261122030728.9368-1-fadouse@pm.me>
Feedback-ID: 173252840:user:proton
X-Pm-Message-ID: f9bcd3e369aefbc9e9addbe820e4d1c933c2307d
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------d159e4b825aa838e8590dceeb959d38559e35183190b62bd9fff304cae4ec4b2"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------d159e4b825aa838e8590dceeb959d38559e35183190b62bd9fff304cae4ec4b2
Content-Type: multipart/mixed;
 boundary=5cd39aaa97b76814b30d443ffd146401da0d18142b359a8b0ace30e5a18f
From: YanXin Li <fadouse@pm.me>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: act_ife: return -EAGAIN after dropping rtnl_lock in load_metaops_and_vet()
Date: Sun, 22 Nov 2026 11:07:28 +0800
Message-ID: <20261122030728.9368-1-fadouse@pm.me>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0

--5cd39aaa97b76814b30d443ffd146401da0d18142b359a8b0ace30e5a18f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

load_metaops_and_vet() unlocks rtnl_lock() to invoke request_module()
when an IFE metadata provider module (such as act_meta_mark) is not
yet loaded, re-acquires rtnl_lock(), validates the metadata attribute,
and returns 0.

Returning 0 after dropping rtnl_lock() violates the serialization
contract of RTNL-locked classifiers (cls_basic, cls_flow, cls_fw,
cls_route, and cls_u32), which hold an unrefcounted filter pointer
(fold) across tcf_exts_validate() -> tcf_ife_init().  A concurrent
RTM_DELTFILTER can delete and RCU-free fold during the unlocked
request_module() window, after which basic_change() executes
list_replace_rcu(&fold->link, &fnew->link) and queues a second
deletion on the freed filter.  Generic KASAN reports:

  BUG: KASAN: slab-use-after-free in basic_change+0xf4c/0x1220
  Read of size 8 at addr ffff88800e043c58 by task test_act_ife_rt/101
  ...
  Allocated by task 101:
   basic_change+0x1e0/0x1220
  Freed by task 57:
   ...
  Oops: general protectio
n fault, probably for non-canonical address
  KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead000000000127]

Every other TC module autoloader that drops rtnl_lock() during filter
updates (tc_action_load_ops(), tcf_em_validate(), and em_text_change())
returns -EAGAIN so tc_new_tfilter() and tcf_action_add() unwind and
replay under a fresh RTNL critical section.

Manipulating TC filters requires CAP_NET_ADMIN in the target network
namespace, which is reachable by an unprivileged local user inside a
user and network namespace when CONFIG_USER_NS=y, CONFIG_MODULES=y,
CONFIG_NET_ACT_IFE is enabled, and an IFE metadata module is not yet
loaded.

When load_metaops_and_vet() drops rtnl_lock() and loads the requested
metadata module, drop the module reference and return -EAGAIN so the
caller replays the request with fresh lookups.  With this change, the
same concurrent RTM_NEWTFILTER and RTM_DELTFILTER sequence cleanly
loads act_meta_mark, replays without to
uching the deleted filter, and
completes with rc=0 and no KASAN or lockdep reports.  Exhaustive
state-space interleaving checking confirms zero use-after-free,
double-free, or deadlock paths remain.  A test case and full
validation logs are available on request.

The vulnerable code is present in upstream mainline v7.4-rc3.
Runtime verification and fix validation were performed in an x86-64
QEMU/KVM guest running v7.4-rc3 with Generic KASAN, UBSAN, and
lockdep.

Fixes: ef6980b6becb ("introduce IFE action")
Cc: stable@vger.kernel.org
Signed-off-by: YanXin Li <fadouse@pm.me>
---
 net/sched/act_ife.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 5a527da0056..5d6ca124e00 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -275,6 +275,14 @@ static int load_metaops_and_vet(u32 metaid, void *val, int len, bool rtnl_held)
 		if (rtnl_held)
 			rtnl_lock();
 		ops = find_ife_oplist(metaid);
+		if (
ops && rtnl_held) {
+			/* We dropped the RTNL mutex in order to perform the
+			 * module load. Tell the caller to replay the request
+			 * under a fresh RTNL critical section.
+			 */
+			module_put(ops->owner);
+			return -EAGAIN;
+		}
 #endif
 	}
 
-- 
2.43.0


--5cd39aaa97b76814b30d443ffd146401da0d18142b359a8b0ace30e5a18f
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - fadouse@pm.me -
 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"
Content-Type: application/pgp-keys; filename="publickey - fadouse@pm.me -
 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuMTAuMAoKeGpNRWFVdU9NUllKS3dZQkJBSGFS
dzhCQVFkQXRuWWxTekhUTEhBMkl6dU5FMUF5OEpyS1VDeDZoUCsvdGM0TApEWENucmV6TkhXWmha
RzkxYzJWQWNHMHViV1VnUEdaaFpHOTFjMlZBY0cwdWJXVSt3c0FSQkJNV0NnQ0RCWUpwClM0NHhB
d3NKQndrUXVaMWd0K1htMlhSRkZBQUFBQUFBSEFBZ2MyRnNkRUJ1YjNSaGRHbHZibk11YjNCbGJu
Qm4KY0dwekxtOXlaem0wQnAzZUVYUldrbklnQ2xXd3ZkeFptbzFYblZiNkZrYWpYVFZNMUIvakF4
VUtDQVFXQUFJQgpBaGtCQXBzREFoNEJGaUVFbVVoYW8zWi9BbkJJNExCWXVaMWd0K1htMlhRQUFM
cTJBUUQ3OEs2cGVkU1gzbGROCnlxZDNPSDF1TWpPM3Y3TFlNaE8rbDdjblNMV3JFQUQrT0NTcTEx
U2VhS29ic1ZHckxlalRNc21Nc1BCOGpueGYKaWQzaENOK3Bld1RPT0FScFM0NHhFZ29yQmdFRUFa
ZFZBUVVCQVFkQXdYZHpWSXFFSC94OEhaalIvUE90MkFpRgpiRW02WXFYWDJqMnYyaUtEc1FNREFR
Z0h3cjRFR0JZS0FIQUZnbWxMampFSkVMbWRZTGZsNXRsMFJSUUFBQUFBCkFCd0FJSE5oYkhSQWJt
OTBZWFJwYjI1ekxtOXdaVzV3WjNCcWN5NXZjbWRkS05RWURGV2NFVmQzeE9IZVFwNnMKeW43OU5G
cE5xa0h6K2l6cElMQm5VZ0tiREJZaEJKbElXcU4yZndKd1NPQ3dXTG1kWUxmbDV0bDBBQUR6UWdE
LwpjSUowODlKa25vZ1RzNnZ2UVorSjNMUklEYUk5K1FtK1Q1cU9tTms0eVhFQkFMUElsSkNTOGFo
NWRCWVphOUwrCkhxamJEbWVTZ0RvNTh1U3graVd3KzZVTAo9TXVzVAotLS0tLUVORCBQR1AgUFVC
TElDIEtFWSBCTE9DSy0tLS0t
--5cd39aaa97b76814b30d443ffd146401da0d18142b359a8b0ace30e5a18f--

--------d159e4b825aa838e8590dceeb959d38559e35183190b62bd9fff304cae4ec4b2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wqsEARYIAF0FgmsCXHoJELmdYLfl5tl0NRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdJtaO558TQB98gEUUdYl0HFiEEmUhao3Z/AnBI
4LBYuZ1gt+Xm2XQAAPBcAP9n1GXXp54EijQOjLaKgb7pOoaUjk7H/lGvqsPp
1icC6gEAxXdOqzK4n/vow5pdf86mAPQMfvWwQ8WFdf2E9RR6Qw4=
=VfXo
-----END PGP SIGNATURE-----


--------d159e4b825aa838e8590dceeb959d38559e35183190b62bd9fff304cae4ec4b2--

