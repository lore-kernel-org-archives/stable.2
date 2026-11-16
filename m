Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810872;
	b=5rfIltoT2ngIOx0OSjp9R/Kd5YLg9GwQwn/Wrs03YF0KQPX3Bg3oAolreEzC+yoKq9Tt
	 BpObB9sbiFNV3rMeZ5Jnv7zpQW6B2jezRueR18a0PqzoK2y91L1yD/+3998KexpoGc4Ij
	 jkJS6FW2Nts94xMtiV9bc1uQy4LFkRwEp27HCKgroKYtONYQnZlTG1KrfhvvXp7rGq2+v
	 nYVHFdIJLHd5y7qTkOochC5++d5ekgdF1n4WKFapXZ7Eiy52C0QOsIn6tWzNaydJpzIVO
	 5Bu/Qye7B2dvKsw1ETz7duJp55ObBfHv5KaBW+5TlJfZHrZReIh3Dar3TKnRUN5aa0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fHZnFX7X6Kt57Oc4zqYHx2brQFPhehsybWGHrYd3t+o=;
	b=b/qMLU27iwob7OXJQd4h09VxzVAalXP/VmRj5uqexrP3ayPCT2StqhL5rfygpwkpOrdn
	 ecALESToMObbOURtuUn+DhvSDFGRaiDOECAVGDZL600/5yjm/85pqbXfL7YbnvU2/1F7H
	 VXeSQx1jmqO3vezqB90v8opAzSiBfqrVSGkrH2ZKDbYDGId0vmmV5u/MV958T4zU2tDeS
	 DBmD1sfbFmIfrI3rFgRA5611x987p2IfUx0jaBgGW7TEjEfc/xCraicFySGjsy0uI+OoJ
	 UFJm/2dQwnaIcBz6zVsVn+BdjtIoMr6CPoCyHEk4lulrEQ5NpGD0/LqCv6iL/JlYfKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=colorfullife.com;
	spf=pass smtp.mailfrom=colorfullife.com;
	dkim=pass header.d=colorfullife-com.20260707.gappssmtp.com header.i=@colorfullife-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TnGap+Ur;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E04606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25E04606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorfullife.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=colorfullife-com.20260707.gappssmtp.com header.i=@colorfullife-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TnGap+Ur
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b001cd92bso1967043f8f.2
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 22:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20260707.gappssmtp.com; s=20260707; t=1794810870; x=1795415670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fHZnFX7X6Kt57Oc4zqYHx2brQFPhehsybWGHrYd3t+o=;
        b=TnGap+UrRgAob4hHgWXHOQ7PrgyxDzks6pmst6NT8BlJht8MF+f/rv0hzM2CTA8Ctz
         3QowrZ3IYKLU4W3u/ay2DMuSiob4XhuqsEoA6Oy6zrVU7fbAkbIbsJbyZLnTRoz1Mld7
         b8jgy3v+zgESQLGJCDw0LSTrKqnIWhdOLiv08LqyXDq+Ht6iO7ilrWUIu4waSIoBM8Sp
         Lc7zn9CN81iSc23fU2SpFa5y/awuu/42sr/zKfem2AWd4DqpI+Vieh86spkyfszGy3xp
         4vx62pHZPJCGnfBblw8v00L5alwrJP0jrMlRpblggCtnnp4rrXWvxZHEalOxEqBDZ1jX
         D2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794810870; x=1795415670;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fHZnFX7X6Kt57Oc4zqYHx2brQFPhehsybWGHrYd3t+o=;
        b=qgAoGoEWHa+HSRPQTlVkw9esoPEynMmtdczofOl8MDKlcEqyCBQV5Nr2oRPZwpmnZz
         1WWg9KcB2KQpRPDJvxkuybJ2CoKAHIzNOiRgIDlYNqhKRx8BWSVkjX4O+RwJGSoEEEej
         swnBMXfOUDS5UoKo7jD9LMh5CRyiFlcp6GO4bisaSFN0oV1dcUGHkWHNJUDJj/dWpzzt
         4OA5lAK257Xppgni1NGAcVWzXxK4Gt1pK2dubd1Oalwdv2bV8NWXqze0N8nGgmgSX4WD
         hDc83DTXnunRadbh94PuH6A8SkTLrn4P1n6eIGTPZJvCBFuwGezT8A+BBHb5NWaZ+Byg
         S8lQ==
X-Forwarded-Encrypted: i=1; AL+hErH2bJgCWvzdv1lMqzywQL3CQylDPoF6S1PBfM6NGZvR7qrKsCDLJh3MRikAyqCP3ujueSOopC4=@vger.kernel.org
X-Gm-Message-State: APuU4Z94wICOeLeJo6aILkYKBVFwKPNq1tHsbg/eMZA6K/1lcyWPKeI0
	+DrXnjVwokjXebjihfeItDpUl6a6S6eDxIslc/FOiVFtDz3p0rWtdkq+Pw896suvyQ==
X-Gm-Gg: AYBFou2rARwpm0d1fozUC3Pw9HfziFh/fy0XENTdydmpBgkBAcpLHFD4JYcIpr5rjrs
	tcLzxMGEGLxMLKkHWfsY2pzNlAvaU9Kz3Nrh1Nncum/khhcNecK7VcdvXd3JtAiRzP/h9yOrQQ4
	tURBetikmdTF7WqiJe3yJ13x067fSxPn5c71NYytp61RYuEuM/EWCZWXcNBcWtCKzlKQVQwvBUu
	CSfuXN94pg168Rob2xyVt5TBLk/rLd3ly1VGViOR04enxHpQWHPULlNLhngzcGbD+NP5D884woo
	PQbJ6NfUxgRPDeNSADNHvitsMGMh9k5CtXl10H+ba1Pi1GEcH0Mbn4a8YrUPxOp1a8rYnyV828y
	TvctGzd5b7LdMXAEpqrg05i1Gydx9zn8pZDCxaTqEmPZ4P0YbapvTWOUX183XDSPyKb/5IVRlCc
	pq/lmRH4Im80sDpVfWWewv4L8PV8VlByLsF2W9u+rcqwGXQ/lxRX9d3RmPFRVjXHfVxM6WyFMZE
	m/JbnYAQOAryqn+/z+cUrdFZqSImEN8LGrPki338UTHLjFa9+ZXz/W85bYn8JBN1RkQo9tgzs9U
	mb7O2wgnsLDuyg38tAs1BWSspdZV5Fng0poChazDUHxpC/2xPmCYNq7qVOP0VB9rjkXJwK/NLMJ
	/gPn1jfMozJkLO1M6uzU1u77hF/C7uUW00Bx/OZypmDhsNNUcMyHFRi8AFAtfN1Dk
X-Received: by 2002:adf:e18d:0:b0:48c:67d6:a87a with SMTP id ffacd0b85a97d-49c70a0f020mr19590904f8f.32.1794810869228;
        Sun, 15 Nov 2026 22:34:29 -0800 (PST)
Received: from ?IPV6:2003:d9:9744:c00:e132:4153:eb23:391b? (p200300d997440c00e1324153eb23391b.dip0.t-ipconnect.de. [2003:d9:9744:c00:e132:4153:eb23:391b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49d7150529dsm14983828f8f.51.2026.11.15.22.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 22:34:28 -0800 (PST)
Message-ID: <0747b78e-0ea7-46a1-a18a-8af18e98bf3c@colorfullife.com>
Date: Mon, 16 Nov 2026 07:34:25 +0100
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
Subject: Re: [PATCH v3] ipc/msg: fix msg_qbytes truncation in IPC_SET
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>, Shuah Khan
 <shuah@kernel.org>, Lu Shuaibing <shuaibinglu@126.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>,
 "Christopher Lameter (Ampere)" <cl@gentwo.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Jan Koester <jan.koester@tuxist.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
References: <20261029-ipc-msg-qbytes-v3-1-fc3f4307c85b@gentwo.org>
Content-Language: en-US
From: Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20261029-ipc-msg-qbytes-v3-1-fc3f4307c85b@gentwo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shubhang,

On 10/29/26 8:35 PM, Shubhang Kaushik (Ampere) wrote:
> The msg_qbytes field in the struct msqid64_ds userspace ABI is an
> unsigned long. Commit 889b331724c82 ("ipc/msg.c: consolidate all
> xxxctl_down() functions") passes that value to msgctl_down() as an int.
>
> On ABIs where unsigned long is wider than unsigned int, this narrows
> msg_qbytes before validation and assignment. For example, an
> unprivileged queue owner can request msg_qbytes = 0x100000000. The
> conversion to int changes this value to zero, which passes the
> msg_ctlmnb check. IPC_SET then succeeds and sets q_qbytes to zero
> instead of rejecting the requested value with EPERM.
>
> For callers with CAP_SYS_RESOURCE, values with bit 31 set are also
> incorrectly sign-extended when assigned to q_qbytes. In particular,
> UINT_MAX becomes ULONG_MAX rather than the requested UINT_MAX.
>
> Keep msg_qbytes as unsigned long through validation and assignment.
> Also preserve its type in ipcctl_obtain_check(), which passes it to the
> unsigned-long audit field.
>
> Add a regression test which drops CAP_SYS_RESOURCE and verifies that
> IPC_SET with a value above UINT_MAX fails with EPERM where unsigned long
> is wider than unsigned int. Skip the test when it is not, capabilities
> are unavailable, or System V message queues are unavailable.
>
> Fixes: 889b331724c82 ("ipc/msg.c: consolidate all xxxctl_down() functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
Reviewed-by: Manfred Spraul <manfred@colorfullife.com>
> ---
> Changes in v3:
>    - Correct the analysis: msg_ctlmnb is unsigned int, so UINT_MAX is
>      already rejected for unprivileged callers on the unfixed kernel.
>    - Test an unprivileged 64-bit msg_qbytes value above UINT_MAX, which
>      truncates to zero on the unfixed kernel.

Thus:

The global (per namespace) limit msg_ctlmnb is limited to UINT_MAX.

On a 64-bit system, root can increase the per-queue limit to ULONG_MAX.

All per queue logic is now unsigned long based:

struct msqid64_ds t::unsigned long  msg_qbytes;
msgctl_down(,,unsigned long msg_qbytes)
struct msg_queue::unsigned long q_qbytes;

Ok from my side.


>    - Skip the test on 32-bit, where unsigned long cannot represent the
>      regression value.
>    - Remove the incorrect queue-limit-bypass and memory-exhaustion claims.
>
> Link to v2: https://lore.kernel.org/r/20261027-ipc-msg-qbytes-v2-1-48d8f72f1359@gentwo.org
> ---
>   ipc/msg.c                                   |  2 +-
>   ipc/util.c                                  |  3 +-
>   ipc/util.h                                  |  3 +-
>   tools/testing/selftests/ipc/Makefile        |  2 +-
>   tools/testing/selftests/ipc/msgctl_qbytes.c | 84 +++++++++++++++++++++++++++++
>   5 files changed, 90 insertions(+), 4 deletions(-)
>
> diff --git a/ipc/msg.c b/ipc/msg.c
> index 62996b97f0ac2137dfc2fa109394d6db1fcb4a0f..116126f1235cd6ce9b819cfd317ef039071b95ca 100644
> --- a/ipc/msg.c
> +++ b/ipc/msg.c
> @@ -399,7 +399,7 @@ copy_msqid_from_user(struct msqid64_ds *out, void __user *buf, int version)
>    * NOTE: no locks must be held, the rwsem is taken inside this function.
>    */
>   static int msgctl_down(struct ipc_namespace *ns, int msqid, int cmd,
> -			struct ipc64_perm *perm, int msg_qbytes)
> +			struct ipc64_perm *perm, unsigned long msg_qbytes)
>   {
>   	struct kern_ipc_perm *ipcp;
>   	struct msg_queue *msq;
> diff --git a/ipc/util.c b/ipc/util.c
> index 1737d776bc089e27495e810569bf302069db3712..c435b2d93a12e92e930358a8bc53a06314d065f5 100644
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -718,7 +718,8 @@ int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out)
>    */
>   struct kern_ipc_perm *ipcctl_obtain_check(struct ipc_namespace *ns,
>   					struct ipc_ids *ids, int id, int cmd,
> -					struct ipc64_perm *perm, int extra_perm)
> +					struct ipc64_perm *perm,
> +					unsigned long extra_perm)
>   {
>   	kuid_t euid;
>   	int err = -EPERM;
> diff --git a/ipc/util.h b/ipc/util.h
> index a55d6cebe6d3b0974548a497fcb889248aed0f87..55a76f94667cd4bb248fbcea26323db8d2778a44 100644
> --- a/ipc/util.h
> +++ b/ipc/util.h
> @@ -180,7 +180,8 @@ void ipc64_perm_to_ipc_perm(struct ipc64_perm *in, struct ipc_perm *out);
>   int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out);
>   struct kern_ipc_perm *ipcctl_obtain_check(struct ipc_namespace *ns,
>   					     struct ipc_ids *ids, int id, int cmd,
> -					     struct ipc64_perm *perm, int extra_perm);
> +					     struct ipc64_perm *perm,
> +					     unsigned long extra_perm);
>   
>   static inline void ipc_update_pid(struct pid **pos, struct pid *pid)
>   {
> diff --git a/tools/testing/selftests/ipc/Makefile b/tools/testing/selftests/ipc/Makefile
> index fad10f2bb57b0f06f0c741fa89f0489f6952eba6..930a334747a6353c86bebe1f4a521aeee3fe8228 100644
> --- a/tools/testing/selftests/ipc/Makefile
> +++ b/tools/testing/selftests/ipc/Makefile
> @@ -12,7 +12,7 @@ endif
>   
>   CFLAGS += $(KHDR_INCLUDES)
>   
> -TEST_GEN_PROGS := msgque
> +TEST_GEN_PROGS := msgctl_qbytes msgque
>   
>   include ../lib.mk
>   
> diff --git a/tools/testing/selftests/ipc/msgctl_qbytes.c b/tools/testing/selftests/ipc/msgctl_qbytes.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..5549229a25eb6852898fdb6cd8e89f9db78444dd
> --- /dev/null
> +++ b/tools/testing/selftests/ipc/msgctl_qbytes.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <errno.h>
> +#include <limits.h>
> +#include <linux/capability.h>
> +#include <stdio.h>
> +#include <sys/msg.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +
> +#include "kselftest.h"
> +
> +static int drop_cap_sys_resource(void)
> +{
> +	struct __user_cap_header_struct hdr = {
> +		.version = _LINUX_CAPABILITY_VERSION_3,
> +	};
> +	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3];
> +	unsigned int index = CAP_SYS_RESOURCE / 32;
> +	__u32 mask = 1U << (CAP_SYS_RESOURCE % 32);
> +
> +	if (syscall(SYS_capget, &hdr, data))
> +		return -1;
> +
> +	data[index].effective &= ~mask;
> +	data[index].permitted &= ~mask;
> +
> +	return syscall(SYS_capset, &hdr, data);
> +}
> +
> +int main(void)
> +{
> +	struct msqid_ds ds;
> +	int msqid;
> +	int ret;
> +
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +#if ULONG_MAX <= UINT_MAX
> +	ksft_exit_skip("requires unsigned long wider than unsigned int\n");
> +#endif
> +
> +	if (drop_cap_sys_resource()) {
> +		if (errno == ENOSYS)
> +			ksft_exit_skip("capabilities are unavailable\n");
> +		ksft_exit_fail_perror("drop CAP_SYS_RESOURCE");
> +	}
> +
> +	msqid = msgget(IPC_PRIVATE, 0600);
> +	if (msqid == -1) {
> +		if (errno == ENOSYS)
> +			ksft_exit_skip("System V message queues are unavailable\n");
> +		ksft_exit_fail_perror("msgget");
> +	}
> +
> +	ret = msgctl(msqid, IPC_STAT, &ds);
> +	if (ret == -1) {
> +		ksft_perror("msgctl(IPC_STAT)");
> +		goto out_fail;
> +	}
> +
> +	/*
> +	 * Without CAP_SYS_RESOURCE, a value above UINT_MAX must be rejected
> +	 * rather than truncated to zero.
> +	 */
> +	ds.msg_qbytes = (unsigned long)UINT_MAX + 1;
> +	errno = 0;
> +	ret = msgctl(msqid, IPC_SET, &ds);
> +	if (ret == -1 && errno == EPERM) {
> +		ksft_test_result_pass("IPC_SET rejects oversized msg_qbytes\n");
> +		msgctl(msqid, IPC_RMID, NULL);
> +		ksft_exit_pass();
> +	}
> +
> +	if (ret == -1)
> +		ksft_perror("msgctl(IPC_SET)");
> +	else
> +		ksft_print_msg("msgctl(IPC_SET) unexpectedly succeeded\n");
> +
> +out_fail:
> +	msgctl(msqid, IPC_RMID, NULL);
> +	ksft_test_result_fail("IPC_SET accepted oversized msg_qbytes\n");
> +	ksft_exit_fail();
> +}
>
> ---
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> change-id: 20261027-ipc-msg-qbytes-49b15931c5b6
>
> Best regards,


