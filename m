Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E438CFED;
	Sat,  1 Aug 2026 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785568454; cv=none; b=VMzJYQHY95q3xI1PBXaG+jyiWbARI+1WBitFTdg8Kz2KkZV8DDhBVrMMCoC6S+r0FEWDo2ttp7TBKjjNhFxCS7kH8PgDvBhsYOOjXL1BNpq2AF7AwSYoer3jB8zjSqarwYRPCyG/HDdb9QS9WCvV4fifzHKVDWpzwn3ldUkF0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785568454; c=relaxed/simple;
	bh=Y3SXvYfPngUH0OI73XvKvr2m/UXdHiuIq4pD5re/+To=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=l0mzsLTWQbnC5LZvjEKNFvZXiRURX9LFvoyBY3eB7/z7Y8cXkmDJtufW+FFahv7UG5zgJM9y3kJC1++xGmkBfIycm4yV6KnxIziFVNo/2vLZ7pbHTQXAbLocatbHCXF4m3kFP5fE2HILY3mYGMYKZprHgvHHlVw1isQtBNS1KGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=dJTZ6HVx; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="dJTZ6HVx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Content-Type:
	Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Content-Transfer-Encoding:Message-Id:References:To; bh=fM6uD0E87
	jFBk1aRIQdaABJS6fgMDzXywzwEo1KmMMY=; b=dJTZ6HVxVSOTSSbVg34J4btxA
	iArzdbNSu89wBjwhZqumyU3WUCUs2md8eGMGIZSXOLrKirkVMzBTwgt679T/IIoP
	sRyy25ONRe3nrTcUBputwrYHGUblTXVk0Aa10cR3LQ7WqKoIagZ2xMnCLqmE+9AM
	4A/VghpWQPiwa17qDQ=
Received: from smtpclient.apple (unknown [106.111.19.250])
	by web1 (Coremail) with SMTP id yAQGZQAHp8a2nG1q88PnAA--.65165S2;
	Sat, 01 Aug 2026 15:13:59 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net] nexthop: account nexthop allocations to memcg
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260730003902.4166545-1-kuba@kernel.org>
Date: Sat, 1 Aug 2026 15:13:46 +0800
Cc: dsahern@kernel.org,
 idosch@nvidia.com,
 davem@davemloft.net,
 edumazet@google.com,
 pabeni@redhat.com,
 horms@kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 yangyx22@mails.tsinghua.edu.cn,
 wangao@seu.edu.cn,
 fengxw06@126.com,
 qli01@tsinghua.edu.cn,
 xuke@tsinghua.edu.cn,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <85095CE8-F0E1-450A-8D9D-A991D28333D6@mails.tsinghua.edu.cn>
References: <20260728060112.30367-1-zhaoyz24@mails.tsinghua.edu.cn>
 <20260730003902.4166545-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-CM-TRANSID:yAQGZQAHp8a2nG1q88PnAA--.65165S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4xGF1DZFW7JrW3uFykXwb_yoWfuFyxpF
	Z5KrZ8GF4DJ348CFs2vF40vFyYk3y8CryUAF4xK34FkwnxKr1SgrW2ka4jva48CF1ruF1F
	vF4jvwnruay5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjsuciUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgAGAWptISFXOQABst

Hi Jakub,

Thank you for both reviews. This is the reply for the second review.

> On Jul 30, 2026, at 08:39, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> --- Patch [1]: [PATCH net] nexthop: account nexthop allocations to =
memcg ---
> commit 1014ad1eb712722973916d53a1c5348624a80550
> Author: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
>=20
> nexthop: account nexthop allocations to memcg
>=20
> This adds GFP_KERNEL_ACCOUNT / __GFP_ACCOUNT to the nexthop creation =
path
> allocations (struct nexthop, struct nh_info, group storage, resilient
> bucket table, per-group stats) and to the transient resilient-table
> notifier buffer in nh_notifier_res_table_info_init().  The stated goal =
is
> to make memory.max constrain nexthop creation by a CAP_NET_ADMIN task =
in
> a container.
>=20
> A couple of questions below about the notifier-table hunk and about =
the
> tags.
>=20
>> nexthop: account nexthop allocations to memcg
>>=20
>> Fixes: ab84be7e54fc ("net: Initial nexthop code")
>> Fixes: f4676ea74b85 ("net: nexthop: Add nexthop group entry stats")
>> Cc: stable@vger.kernel.org
>=20
> [Severity: Low]
> Are the Fixes: tags and the stable Cc appropriate here?  Switching
> allocations to GFP_KERNEL_ACCOUNT does not fix an incorrect result, it
> changes the success/failure profile of an existing uAPI operation.
>=20
> After a stable backport, RTM_NEWNEXTHOP can start returning -ENOMEM
> inside a memory.max-constrained cgroup on kernels where it previously
> succeeded, which looks like a functional change for routing daemons
> running in containers.
>=20
> The operation still requires CAP_NET_ADMIN in the netns owner's user
> namespace, so no privilege boundary is being closed - only accounting
> accuracy changes.  Would net-next without the Fixes:/Cc: stable tags =
be a
> better target, with the transient notifier hunk split out?

I agree that the fix changes the point at which RTM_NEWNEXTHOP can fail
under memory.max. However, I view that failure as the intended =
enforcement
of memory.max: the current uncharged allocations let a cgroup retain =
kernel
memory outside its configured hard limit.

For that reason, I had considered this a bug fix suitable for net, and
possibly stable once the patches are properly split and validated. Do =
you
prefer net-next because of the breadth and regression risk of the =
allocation
changes, rather than the -ENOMEM behavior itself? I will follow your
guidance on the target and tags.

>=20
>> The nexthop creation path allocates struct nexthop, struct nh_info,
>> group storage, resilient bucket tables, transient notifier tables and
>> per-group stats without memcg accounting.
>=20
> [Severity: Low]
> The changelog says "transient notifier tables" in the plural, but only
> one of the five transient notifier allocations in net/ipv4/nexthop.c =
is
> converted.  These remain on plain GFP_KERNEL:
>=20
>  nh_notifier_single_info_init()
> info->nh =3D kzalloc_obj(*info->nh);
>=20
>  nh_notifier_mpath_info_init()
> info->nh_grp =3D kzalloc_flex(*info->nh_grp, nh_entries, num_nh);
>=20
>  nh_notifier_res_bucket_info_init()
> info->nh_res_bucket =3D kzalloc_obj(*info->nh_res_bucket);
>=20
>  nh_notifier_grp_hw_stats_init()
> info->nh_grp_hw_stats =3D kzalloc_flex(*info->nh_grp_hw_stats, stats,
>     nhg->num_nh);
>=20
> Since nh_notifier_grp_info_init() dispatches to
> nh_notifier_mpath_info_init() for hash_threshold (MPATH) groups, a =
group
> created through the exact path described in the changelog gets no
> notifier-table accounting at all, and =
call_nexthop_res_table_notifiers()
> also builds an unaccounted num_nh-sized mpath table during resilient
> group replace.
>=20
> Could the policy be made all-or-nothing here, and the changelog =
adjusted
> to match what the code does?

Agreed. The partial notifier conversion and the corresponding changelog
wording are both incorrect.

After reviewing the lifetime and call contexts, I will make the policy =
here
"none": I will drop the notifier hunk rather than convert the remaining
notifier allocations or split it into a separate patch. These buffers =
are
temporary notification payloads, freed after the callback, rather than
persistent nexthop state. They can also be allocated during notifier =
replay
or deletion, where GFP_KERNEL_ACCOUNT would charge the current context
rather than the nexthop creator and could make notification delivery =
fail.

I will remove "transient notifier tables" from the commit message. The
revised patch will describe and account only persistent nexthop =
allocations.

>=20
>> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
>> index 44fe75004cac..c8685c583579 100644
>> --- a/net/ipv4/nexthop.c
>> +++ b/net/ipv4/nexthop.c
>> @@ -169,7 +169,7 @@ static int nh_notifier_res_table_info_init(struct =
nh_notifier_info *info,
>> info->type =3D NH_NOTIFIER_INFO_TYPE_RES_TABLE;
>> size =3D struct_size(info->nh_res_table, nhs, num_nh_buckets);
>> info->nh_res_table =3D __vmalloc(size, GFP_KERNEL | __GFP_ZERO |
>> -       __GFP_NOWARN);
>> +       __GFP_NOWARN | __GFP_ACCOUNT);
>> if (!info->nh_res_table)
>> return -ENOMEM;
>=20
> [Severity: Medium]
> Should this particular allocation be accounted at all?  It is not on =
the
> nexthop creation path the changelog describes.  The buffer only exists =
to
> hand resilient-group state to notifier listeners and is released =
before
> the notifier call returns:
>=20
> net/ipv4/nexthop.c:nh_notifier_grp_info_fini() {
> if (nhg->hash_threshold)
> kfree(info->nh_grp);
> else if (nhg->resilient)
> vfree(info->nh_res_table);
> }
>=20
> So it cannot accumulate, and charging it does not add containment.  =
Two
> side effects come with it though.
>=20
> First, whose memcg gets charged?  The notifier paths run in the =
context
> of whoever triggers the notification, not the creator of the nexthop:
>=20
>  remove_nexthop() -> call_nexthop_notifiers(NEXTHOP_EVENT_DEL)
> (also reached via nh_netdev_event -> nexthop_flush_dev)
>  replace_nexthop_single() err_notify -> =
call_nexthop_notifiers(REPLACE)
>  remove_nh_grp_entry() -> call_nexthop_notifiers(REPLACE)
>  register_nexthop_notifier() / __unregister_nexthop_notifier()
> -> nexthops_dump() -> nh_notifier_info_init() for every
>   existing nexthop
>=20
> Can a cgroup end up charged here for nexthops belonging to other
> cgroups, for example when a driver module registers a nexthop notifier
> and the replay loop walks every resilient nexthop in the netns?
>=20
> Second, does this make notifier delivery fail on demand?  =
__GFP_ACCOUNT
> is honoured for vmalloc pages, so with a memcg at memory.max this
> __vmalloc() can now fail while the system is globally healthy, and
> __GFP_NOWARN keeps it quiet.  The failure happens before the chain is
> called:
>=20
> net/ipv4/nexthop.c:call_nexthop_notifiers() {
> err =3D nh_notifier_info_init(&info, nh);
> if (err) {
> NL_SET_ERR_MSG(extack, "Failed to initialize nexthop notifier info");
> return err;
> }
>=20
> and the callers do not stop on that error:
>=20
> net/ipv4/nexthop.c:remove_nexthop() {
> call_nexthop_notifiers(net, NEXTHOP_EVENT_DEL, nh, NULL);
>=20
> /* remove from the tree */
> rb_erase(&nh->rb_node, &net->nexthop.rb_root);
>=20
> The return value is discarded and the nexthop is erased and freed
> anyway.  replace_nexthop_single()'s err_notify path also discards it,
> remove_nh_grp_entry() only pr_err()s, and =
__unregister_nexthop_notifier()
> ignores nexthops_dump()'s status while nexthops_dump() breaks out at =
the
> first error, skipping DEL for all remaining nexthops.
>=20
> The fail-silent error handling in those callers is pre-existing and =
not
> introduced by this patch, but does this change turn it into something =
a
> task can trigger at will from inside a constrained cgroup?  With an
> offload listener such as mlxsw or netdevsim registered, that would =
leave
> driver state for nexthops the kernel has already freed, and would let
> register_nexthop_notifier() be made to fail for the whole netns.
>=20
> Would keeping nh_notifier_res_table_info_init() on plain GFP_KERNEL =
and
> accounting only the persistent objects (struct nexthop, struct =
nh_info,
> struct nh_group, res_table, per-group stats) avoid all of this?

I agree that this allocation should remain on plain GFP_KERNEL.

__GFP_ACCOUNT would charge the vmalloc backing pages to the current =
memcg,
not to the cgroup which created the resilient nexthop. Therefore =
notifier
replay or deletion could charge an unrelated cgroup while walking =
existing
nexthops in the netns.

It could also make nh_notifier_info_init() fail before the notifier =
chain is
called when the current cgroup is at memory.max. Since some callers =
discard
that error and continue, this could skip notification for an object =
which is
then removed or otherwise changed.

I will remove this hunk rather than account the other notifier =
allocations,
and remove the notifier-table wording from the changelog. The revised =
patch
will account only persistent nexthop state, for which the allocation =
context
and lifetime are directly attributable to the nexthop operation.

>=20
> [ ... ]
> --=20
> pw-bot: cr

Please let me know if further changes are needed.

Thanks,
Yizhou=

