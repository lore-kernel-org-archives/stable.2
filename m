Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161564;
	b=aPmTGMI0/LlB3aROaAn2ZySh4M7A6VdDj1vQmPLP9I8JxWjkGtqiQjhFcEF1NLipft1F
	 gml3haWcQjWTUQdDmfdSckcYxnzKkL/48HqJNHEnOk/kjHRlUWSnwjvQPpU0gKl8YDq52
	 7t2FeJEMx1A78eSZWEkPt4RUb7DaIF3WThE/kor4+BqjXIs4LmfcRf23EMLBUmu+X9kCi
	 yA9O1FSJc43M3C0hP+0pG0yAQ9I3+bKTobrKj2Ed76OwxutnkUbq5B4ZZDbO6e1FAp0/O
	 cFW2ZbUWd2OcZhVA6DXsR2VaRhg+/zKdwNE0Tx7qh6KpsqCpUW78Vm+MpdZdhs1Zv6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161564;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+tA0EsUf22weBiJ+LMGUgfYrWb2VIx2xFegNiivuIJ8=;
	b=ey1uinNKy9utjXA4ncuiIimSzFEsyemftW2eQj7nEe2Kx+0s3O3M5DLf4aqyoMqV1FiL
	 1iROyLVHxFoxsJoQuiC69tOuxRRoAKiTT519oCFIKq4pEuZx1JZKB1lQLKFYL/8C2D35Q
	 4XoM18q78tyff5kfj1ZK7Ea/AYkMkeP9gDZxPdhH6c5uX0JbIrM8jtwlRUBv3lCGvi/y8
	 vP6LvvwDJm1YMuunXTDzJXgxhdzE8QUv4mk4X+zzKcNroK9hYPBXCKEB3RLqH7lsQbj+0
	 V49NT7GbJNDeUb9/l9luYvtw6qbxVGzodEuxkeA5JwCQgezh9+Np+kLCerrk2NMxzxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=o2rXvuMU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA38606A31A;
	Wed, 28 Oct 2026 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=o2rXvuMU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58E61F01828;
	Wed, 28 Oct 2026 04:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793161563;
	bh=+tA0EsUf22weBiJ+LMGUgfYrWb2VIx2xFegNiivuIJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=o2rXvuMUFT4dGkW8gpCdpx+wA7Xq6eznJfQHt/NGheE7Pm62TIG0DJe0lxc9q+h7b
	 1D1e6ic4wOdAwwLn6LibXpUnv6917w8IM9oXGG79EXOSVv4tpUOCRq0IRTdczSrvai
	 C3fRlSjEoEZLoWu/x5LiSMC7SpGdFdhSYnSeX2LI=
Date: Tue, 27 Oct 2026 21:26:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Cc: Shuah Khan <shuah@kernel.org>, Lu Shuaibing <shuaibinglu@126.com>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>,
 "Christopher Lameter (Ampere)" <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Koester <jan.koester@tuxist.de>
Subject: Re: [PATCH] ipc/msg: prevent msg_qbytes limit bypass in IPC_SET
Message-Id: <20261027212602.e839932c4f7841c007332ab8@linux-foundation.org>
In-Reply-To: <20261027-ipc-msg-qbytes-v1-1-8896db4071f9@gentwo.org>
References: <20261027-ipc-msg-qbytes-v1-1-8896db4071f9@gentwo.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2026 20:35:00 -0700 "Shubhang Kaushik (Ampere)" <sh@gentwo.org> wrote:

> The msg_qbytes field in the msqid64_ds userspace ABI is an unsigned
> long. Commit 889b331724c82 ("ipc/msg.c: consolidate all xxxctl_down()
> functions") passed that value to msgctl_down() as an int.
> 
> An unprivileged owner can set msg_qbytes to UINT_MAX. The narrowing
> conversion produces -1 on supported Linux targets, so the check against
> the int-valued msg_ctlmnb sysctl does not reject the request:
> 
>         if (msg_qbytes > ns->msg_ctlmnb &&
>             !capable(CAP_SYS_RESOURCE))
> 
> The value is then assigned to the unsigned long q_qbytes field, setting
> it to ULONG_MAX. This bypasses the CAP_SYS_RESOURCE requirement for
> increasing a queue above MSGMNB and lets an unprivileged user increase
> queue capacity without the configured per-queue limit.
> 
> Keep msg_qbytes as unsigned long through validation and assignment.
> Also preserve its type in ipcctl_obtain_check(), which supplies it to
> the unsigned-long audit field.
> 
> Add a regression test which drops CAP_SYS_RESOURCE and verifies that
> IPC_SET with UINT_MAX fails with EPERM.

Thanks.

Manfred and Davidlohr help out with ipc/, although MAINTAINERS keeps
that secret (I'm working on changing this).

My AI sidekick said:

: The kernel change looks right. One small selftest fix: please report
: SKIP for ENOSYS from either capability setup or msgget(). With
: CONFIG_MULTIUSER=n, capget/capset are unavailable and the unprivileged
: case cannot be exercised. CONFIG_SYSVIPC=n makes msgget unavailable.
: Other setup and creation errors should still fail.
: 
: Please mention the practical consequence in the changelog: an
: unprivileged queue owner can bypass both the byte limit and the queued
: message-count limit. Even zero-length messages consume kernel memory.
: Subsequent sends can cause memory pressure or exhaustion beyond the
: configured per-queue allowance, subject to the other resource limits.
: 
: The Fixes tag is correct and this warrants stable. Don't add a v5.6+
: restriction: the introducing change was backported, and the bug is
: present in v5.4.19 and v4.19.103 too.
: 
: I found no second confirmed capacity bypass in the adjacent IPC paths.
: Jan Koester's "[RFC PATCH v2 30/41] ipc: add IPC_STAT_R and IPC_SET_R"
: touches these same signatures and retains int qbytes. Please preserve
: this unsigned-long correction when the two changes are integrated.
: 
: https://lists.openwall.net/linux-kernel/2026/10/21/347

> Fixes: 889b331724c82 ("ipc/msg.c: consolidate all xxxctl_down() functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
> ---
>  ipc/msg.c                                   |  2 +-
>  ipc/util.c                                  |  3 +-
>  ipc/util.h                                  |  3 +-
>  tools/testing/selftests/ipc/Makefile        |  2 +-
>  tools/testing/selftests/ipc/msgctl_qbytes.c | 75 +++++++++++++++++++++++++++++
>  5 files changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/ipc/msg.c b/ipc/msg.c
> index 62996b97f0ac2137dfc2fa109394d6db1fcb4a0f..116126f1235cd6ce9b819cfd317ef039071b95ca 100644
> --- a/ipc/msg.c
> +++ b/ipc/msg.c
> @@ -399,7 +399,7 @@ copy_msqid_from_user(struct msqid64_ds *out, void __user *buf, int version)
>   * NOTE: no locks must be held, the rwsem is taken inside this function.
>   */
>  static int msgctl_down(struct ipc_namespace *ns, int msqid, int cmd,
> -			struct ipc64_perm *perm, int msg_qbytes)
> +			struct ipc64_perm *perm, unsigned long msg_qbytes)
>  {
>  	struct kern_ipc_perm *ipcp;
>  	struct msg_queue *msq;
> diff --git a/ipc/util.c b/ipc/util.c
> index 1737d776bc089e27495e810569bf302069db3712..c435b2d93a12e92e930358a8bc53a06314d065f5 100644
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -718,7 +718,8 @@ int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out)
>   */
>  struct kern_ipc_perm *ipcctl_obtain_check(struct ipc_namespace *ns,
>  					struct ipc_ids *ids, int id, int cmd,
> -					struct ipc64_perm *perm, int extra_perm)
> +					struct ipc64_perm *perm,
> +					unsigned long extra_perm)
>  {
>  	kuid_t euid;
>  	int err = -EPERM;
> diff --git a/ipc/util.h b/ipc/util.h
> index a55d6cebe6d3b0974548a497fcb889248aed0f87..55a76f94667cd4bb248fbcea26323db8d2778a44 100644
> --- a/ipc/util.h
> +++ b/ipc/util.h
> @@ -180,7 +180,8 @@ void ipc64_perm_to_ipc_perm(struct ipc64_perm *in, struct ipc_perm *out);
>  int ipc_update_perm(struct ipc64_perm *in, struct kern_ipc_perm *out);
>  struct kern_ipc_perm *ipcctl_obtain_check(struct ipc_namespace *ns,
>  					     struct ipc_ids *ids, int id, int cmd,
> -					     struct ipc64_perm *perm, int extra_perm);
> +					     struct ipc64_perm *perm,
> +					     unsigned long extra_perm);
>  
>  static inline void ipc_update_pid(struct pid **pos, struct pid *pid)
>  {
> diff --git a/tools/testing/selftests/ipc/Makefile b/tools/testing/selftests/ipc/Makefile
> index fad10f2bb57b0f06f0c741fa89f0489f6952eba6..930a334747a6353c86bebe1f4a521aeee3fe8228 100644
> --- a/tools/testing/selftests/ipc/Makefile
> +++ b/tools/testing/selftests/ipc/Makefile
> @@ -12,7 +12,7 @@ endif
>  
>  CFLAGS += $(KHDR_INCLUDES)
>  
> -TEST_GEN_PROGS := msgque
> +TEST_GEN_PROGS := msgctl_qbytes msgque
>  
>  include ../lib.mk
>  
> diff --git a/tools/testing/selftests/ipc/msgctl_qbytes.c b/tools/testing/selftests/ipc/msgctl_qbytes.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..fdf3420173de99ece66c69ff8418a46878d56dbd
> --- /dev/null
> +++ b/tools/testing/selftests/ipc/msgctl_qbytes.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <errno.h>
> +#include <limits.h>
> +#include <linux/capability.h>
> +#include <stdio.h>
> +#include <string.h>
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
> +	if (drop_cap_sys_resource())
> +		ksft_exit_fail_perror("drop CAP_SYS_RESOURCE");
> +
> +	msqid = msgget(IPC_PRIVATE, 0600);
> +	if (msqid == -1)
> +		ksft_exit_fail_perror("msgget");
> +
> +	ret = msgctl(msqid, IPC_STAT, &ds);
> +	if (ret == -1) {
> +		ksft_perror("msgctl(IPC_STAT)");
> +		goto out_fail;
> +	}
> +
> +	/*
> +	 * msg_ctlmnb is an int, so UINT_MAX must require
> +	 * CAP_SYS_RESOURCE.
> +	 */
> +	ds.msg_qbytes = UINT_MAX;
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
> base-commit: 8a36f53fd5ec3eff01f1b637d42cbdc3821d0493
> change-id: 20261027-ipc-msg-qbytes-49b15931c5b6
> 
> Best regards,
> -- 
> Shubhang Kaushik (Ampere) <sh@gentwo.org>
