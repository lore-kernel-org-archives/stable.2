Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243867;
	b=NucTJN3G+581COmWCqSow5a3fK8KxRMDkQeVKXuawWWdoKQGxxf62Bpv5Oaw10Jvz6A2
	 cdvyc4tS6wH95Y7QuMe2XFdAg22PlE2b1guplQh+dFMO3Qt11Fqfj+WbKZN8GDPLnjWEH
	 JgNsfqMwjtVGdRdSrXxkaP9GFMPIUkeIYLbTep1F/onM3ltTZUr+7Ev5Uk3T8hCGKq6AE
	 QdheJr2kc1f20K6Vh/HRPr1t/9NL3Rw+6eul1eyj0PGBNbZZjbHDc6kBEfumxn81To965
	 UjQSR2Kiq7zCIw6aNgxcBltcG+iyyibtGIZ+/Cg78RSmTtztFG3cP3nB1KVav0cH29A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243867;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4s4vz/2lZSk1zPYGEgfTAHKdIOWiKt/yvvz+nzylTtE=;
	b=5XXJ+dKRS+K132gZvW2wInhJoA968Arg84cgtjPbx/4CEm5y3qJM8WFmIUXz9EDGXjPh
	 9leTpRjtKBF7Byr6lZiHVp2rX554UPARficULyxS491ECmr3VJOc2Yc2/jiVmWjttwgEm
	 k3ExvkYPwSLJMN9dqTnLZFGPLTVvD5DAli9nKS2vDBwxMEc+hjTBMwZ25V1HP8Hu+AWVP
	 yu6zzDiFD0Hq5PJXPUoSqhIs/mCyCntX3cr2349aXAjCyJwjcCDmA8jKSEomlFMeDKc50
	 rzqkKV1jVY7A3JTdNPyFQHxKnBZDTJ8pYqesUuhKWm07bct6D0oY/jtacV3Ks0RIERw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GE12sbXd;
	arc=none smtp.remote-ip=91.218.175.111
Received: from mta0.migadu.com (out-111.mta0.migadu.com [91.218.175.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3A606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CD3A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GE12sbXd
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hK2jYhXd7QumlrkLzGIa920gtxKqeJN/+zYTUnE5UPc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793243863; v=1; x=1793848663;
 b=GE12sbXdGo6rbK9ih6arPwWf3izPG03aWZBF0cjYJy76qLj1WD9n8lWRQiRBEfKYRnuYS47j
 DJ7kVmU+pMURWr3iUOrB+gXpXWTS/sh83oNREN8M4uXaEhQ8SqXud12QHdgDBGJmjEGGUag/R0o
 OqyVtAjUjFnGCGONrqFM2dEg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b677ac56b3144682;
	Thu, 29 Oct 2026 03:17:42 +0000
X-Mizu-Trace-ID: b677ac56b3144682
X-Migadu-Flow: FLOW_OUT
Message-ID: <e0d50e17-0e94-4920-a960-fadd93e31e05@linux.dev>
Date: Thu, 29 Oct 2026 11:17:28 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] kcm: reject attaching sockets with a ULP, and
 TLS on KCM sockets
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261028173533.2658096-1-rjethwani@purestorage.com>
 <20261028173533.2658096-2-rjethwani@purestorage.com>
 <auJcgy0IIfavE37T@google.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <auJcgy0IIfavE37T@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/29/26 4:41 AM, Kuniyuki Iwashima wrote:
> On Wed, 28 Oct 2026 11:35:32 -0600, Rishikesh Jethwani wrote:
>> KCM and kTLS RX do not work together, in either order.
>>
>> KCM's psock_data_ready() is the lower socket's data_ready callback. It
>> can run in softirq context under read_lock_bh(&sk->sk_callback_lock),
>> and calls strp_data_ready(), which invokes sock->ops->read_sock()
>> inline. With kTLS RX, that is tls_sw_read_sock(), which can sleep: it
>> allocates with sk->sk_allocation, waits for async crypto, flushes the
>> socket backlog, and may wait in tls_rx_reader_acquire().
>>
>> Found by code review. On an unmodified kernel with
>> CONFIG_DEBUG_ATOMIC_SLEEP, sending TLS records over loopback to a socket
>> with software kTLS RX attached to a KCM mux reports:
>>
>>    BUG: sleeping function called from invalid context at include/linux/sched/mm.h:321
>>    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 189, name: ksoftirqd/34
>>    Call Trace:
>>     __might_resched
>>     kmem_cache_alloc_node_noprof
>>     __alloc_skb
>>     alloc_skb_with_frags
>>     tls_rx_one_record
>>     tls_sw_read_sock
>>     strp_read_sock
>>     strp_data_ready
>>     psock_data_ready [kcm]
>>
>> Before commit 662fbcec32f4 ("net/tls: implement ->read_sock()"), TLS
>> inherited tcp_read_sock(), so KCM parsed the ciphertext in the TCP
>> receive queue as messages. HW TLS RX uses the same proto_ops as SW
>> RX, so it is affected the same way.
>>
>> The two also stack socket callbacks and neither restores the other's:
>> with TLS RX configured after the attach, kcm_unattach() overwrites
>> tls_data_ready(), and releasing TLS RX later reinstalls
>> psock_data_ready() on a socket no longer attached to KCM. On TX,
>> kcm_unattach() restores its saved sk_write_space, dropping
>> tls_write_space().
>>
>> There is no known user of this combination, so reject it, as was done
>> for sockmap in commit 460e6486617c ("tls: reject the combination of TLS
>> and sockmap"):
>>
>>   - kcm_attach() refuses sockets that already have any ULP, not only
>>     TLS, as sk_psock_init() does for sockmap, with -EOPNOTSUPP like its
>>     other refusals;
>>   - tls_init() refuses sockets attached to KCM with -EINVAL, like
>>     __tcp_set_ulp() and the sockmap check, tracked by a new SOCK_KCM
>>     flag set on attach and cleared on unattach.
>>
>> sk_user_data cannot serve as the marker: sunrpc and nvme-tcp set it on
>> sockets that tlshd later upgrades to TLS, so it is already set when
>> tls_init() runs. Unlike sockmap, both sides run under the lower
>> socket's lock (tcp_set_ulp() asserts this), so the check is made at ULP
>> install rather than at key configuration.
>>
>> This is a user-visible change that will also reach stable kernels:
>> attaching a socket with a ULP now fails with -EOPNOTSUPP, and installing
>> TLS on an attached socket fails with -EINVAL. Every refused setup was
>> already broken as described above, except one where only kTLS TX is
>> configured. Such a socket still passes data, because read_sock() stays
>> tcp_read_sock() until kTLS RX is configured, and KCM transmits with
>> sock_sendmsg(), so records reach tls_sw_sendmsg(). It is still wrong: if
>> TLS was armed before the attach, psock_write_space() shadows
>> tls_write_space() and does not chain to it, so a record deferred on a
>> full send buffer waits for the next send; if TLS was armed after the
>> attach, the chain works until kcm_unattach() drops tls_write_space(), as
>> above. The direction is not known at ULP install, so refusing it keeps
>> one rule for both orders and matches sk_psock_init().
>>
>> Tested with CONFIG_DEBUG_ATOMIC_SLEEP: both orders are now rejected,
>> plain KCM still delivers messages, and the TLS ULP can be installed
>> after SIOCKCMUNATTACH.
>>
>> Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Link: https://lore.kernel.org/netdev/3108e934-ec00-458b-8720-450554b35b55@linux.dev/
>> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
>> ---
>>   include/net/sock.h |  1 +
>>   net/kcm/kcmsock.c  | 12 ++++++++++++
>>   net/tls/tls_main.c |  6 ++++++
>>   3 files changed, 19 insertions(+)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 173b37b2b8bb..e579a4a96c8e 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -1024,6 +1024,7 @@ enum sock_flags {
>>   	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
>>   	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
>>   	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
>> +	SOCK_KCM, /* Attached to a KCM mux as a lower socket */
> I guess this does not compile for 32-bit ?
>


I think it is a waste of sock_flags. Can we use a dummy ULP instead?
KCM takes over the socket like a ULP does, so once it holds icsk_ulp_ops,

tcp_set_ulp() refuses TLS with -EEXIST on its own and no change is 
needed on the TLS side.


Something like (not tested):


--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -30,11 +30,19 @@
#include <net/kcm.h>
#include <net/netns/generic.h>
#include <net/sock.h>
+#include <net/tcp.h>
#include <uapi/linux/kcm.h>
#include <trace/events/sock.h>

unsigned int kcm_net_id;

+/* Not registered, so TCP_ULP can't select it. It only holds
+ * icsk_ulp_ops so tcp_set_ulp() refuses other ULPs like kTLS.
+ */
+static const struct tcp_ulp_ops kcm_ulp_ops = {
+       .name = "kcm",
+};
+
static struct kmem_cache *kcm_psockp __read_mostly;
static struct kmem_cache *kcm_muxp __read_mostly;
static struct workqueue_struct *kcm_wq;
@@ -1272,6 +1280,14 @@
               goto out;
       }

+       /* KCM takes over read_sock() and the socket callbacks like a ULP
+        * does, the two can't stack.
+        */
+       if (inet_csk_has_ulp(csk)) {
+               err = -EOPNOTSUPP;
+               goto out;
+       }
+
       psock = kmem_cache_zalloc(kcm_psockp, GFP_KERNEL);
       if (!psock) {
               err = -ENOMEM;
@@ -1305,6 +1321,7 @@
       psock->save_write_space = csk->sk_write_space;
       psock->save_state_change = csk->sk_state_change;
       csk->sk_user_data = psock;
+       inet_csk(csk)->icsk_ulp_ops = &kcm_ulp_ops;
       WRITE_ONCE(csk->sk_data_ready, psock_data_ready);
       WRITE_ONCE(csk->sk_write_space, psock_write_space);
       csk->sk_state_change = psock_state_change;
@@ -1382,6 +1399,7 @@
        */
       write_lock_bh(&csk->sk_callback_lock);
       csk->sk_user_data = NULL;
+       inet_csk(csk)->icsk_ulp_ops = NULL;
       WRITE_ONCE(csk->sk_data_ready, psock->save_data_ready);
       WRITE_ONCE(csk->sk_write_space, psock->save_write_space);
       csk->sk_state_change = psock->save_state_change;


